class ClansController < ApplicationController
  add_breadcrumb "Clans Verwalten", "clans_path"
  before_filter :check_member, :only => [:leave]
  
  def index
    @clans = current_user.clans
    @inquiries = ClanJoinInquiry.find_all_by_user_id current_user.id
  end

  def show
    
  end

  def new
    add_breadcrumb 'Clan gründen'
    @clan = Clan.new
  end

  def create
    add_breadcrumb 'Clan gründen'
    @clan = Clan.new params[:clan]
    @clan.owner = current_user
    if @clan.save
      flash[:notice] = "Clan erfolgreich erstellt"
      redirect_to clans_path
    else
      render :action => "new"
    end
  end
  
  def leave
    current_user.leave_clan @clan
    flash[:notice] = "Erfolgreich aus dem Clan ausgetreten"
    redirect_to clans_path
  end
  
  private
  
  def check_member
    @clan = Clan.find params[:id]
    raise Exceptions::Access unless current_user.belongs_to_clan? @clan
  end
end
