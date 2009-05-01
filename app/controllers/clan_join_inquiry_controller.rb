class ClanJoinInquiryController < ApplicationController
  before_filter :init_inquiry, :only => [:update]
  before_filter :init_destroy, :only => :destroy
  
  def new
    render :layout => false
  end
  
  def create
    @search_clan = Clan.find_by_uniq params[:clan_join_inquiry][:clan_uniq]
    redirect_to my_clans_path and flash[:notice] = "Clan #{params[:clan_join_inquiry][:clan_name]} wurde nicht gefunden" and return if @search_clan.nil?
    redirect_to my_clans_path and flash[:notice] = "Es existiert bereits eine Anfrage von dir an den Clan '#{params[:clan_join_inquiry][:clan_name]}' bitte warte die Antwort ab" and return unless ClanJoinInquiry.find(:first, :conditions => {:clan_id => @search_clan, :user_id => current_user.id}).nil?
    redirect_to my_clans_path and flash[:notice] = "Du bist bereits Mitglied im Clan '#{params[:clan_join_inquiry][:clan_name]}'" and return if current_user.clans.include?(@search_clan)
    ClanJoinInquiry.create(:user_id => current_user.id, :clan_id => @search_clan.id, :inquiry_text => params[:clan_join_inquiry][:inquiry_text])
    flash[:notice] = "Bewerbung erfolgreich erstellt"
    Postoffice.deliver_join_inquiry(@search_clan, current_user)
    redirect_to my_clans_path
  end
  
  def update
    @clan.add_user(@inquiry.user, @squad)
    Postoffice.deliver_join_inquiry_accepted(@inquiry)
    @inquiry.destroy
    flash[:notice] = "User erfolgreich in Clan aufgenommen"
    redirect_to squads_path
  end
  
  def destroy
    inq = @inquiry.dup
    @inquiry.destroy
    flash[:notice] = "Anfrage zurückgezogen" and redirect_to my_clans_path and return if params[:from] == "user"
    flash[:notice] = "Anfrage abgelehnt" and Postoffice.deliver_join_inquiry_denied(inq) and redirect_to squads_path
  end
  
  private
  def init_inquiry
    @inquiry = ClanJoinInquiry.find params[:id]
    @clan = @inquiry.clan
    raise Exceptions::Access unless @user.owns_clan? @clan
    @squad = Squad.find params[:inquiry][:squad_id]
    raise Exceptions::Access unless @clan.squads.include? @squad
  end
  
  def init_destroy
    @inquiry = ClanJoinInquiry.find params[:id]
    @clan = @inquiry.clan
    if params[:from] == "user"
      redirect_to my_clans_path and flash[:error] = "Fehler beim zurückziehen der Anfrage" and return unless @inquiry.user == current_user
    else
      redirect_to squads_path and flash[:error] = "Fehler beim ablehnen der Anfrage" and return unless current_user.owns_clan? @clan
    end
  end
  
  def squads_path
    {:controller => "squad", :action => "index", :clan_id => is_portal? ? @clan.id : nil}
  end
end
