class SquadController < ApplicationController

  before_filter :init_clan
  before_filter :init_squad, :only => [:edit, :update, :destroy, :confirm_users, :confirm_users_save]
  
  def index
    @squads = @clan.squads.find(:all, :include => :users)
    @inquiries = @clan.clan_join_inquiries
  end

  def new
    @squad = Squad.new
    render :layout => false
  end

  def create
    @squad = @clan.squads.new params[:squad]
    if @squad.save
      flash[:notice] = "Squad erstellt"
    else
      flash[:error] = @squad.errors.full_messages.join("<br>")
    end
    redirect_to :action => "index", :clan_id => params[:clan_id]
  end
  
  def edit
    render :layout => false
  end
  
  def update
    @squad.name = params[:squad][:name]
    if @squad.save
      flash[:notice] = "Squad geändert"
    else
      flash[:error] = @squad.errors.full_messages.join("<br>") 
    end
    redirect_to :action => "index", :clan_id => params[:clan_id]
  end

  def destroy
    redirect_to(:action => "confirm_users", :id => @squad.id, :clan_id => @clan.id) and return unless @squad.save_destroy_users?
    if @squad.destroy
      flash[:notice] = "Squad gelöscht"
    else
      flash[:error] = "Squad konnte nicht gelöscht werden"
    end
    redirect_to :action => "index", :clan_id => params[:clan_id]
  end

  def confirm_users
    add_breadcrumb "User bestätigen"
  end
  
  def confirm_users_save
    @squad.users.each do |u|
      user_action = params[:squad_user][u.id.to_s]
      if user_action == "delete"
        u.squads -= [@squad] 
      else
        Squad.move_user u, @squad, @clan.squads.find(user_action.to_i)
      end
    end
    destroy
  end

  private

  def init_clan
    if params[:clan_id].nil?
      @clan = current_site.clan
      add_breadcrumb 'Squads', "squads_path"
    else
      @clan = Clan.find params[:clan_id]
      raise Exceptions::Access unless @user.owns_clan? @clan
      add_breadcrumb 'meine Clans', "clans_path"
      add_breadcrumb @clan.name + " User verwalten"
    end
  end
  
  def init_squad
    @squad = @clan.squads.find params[:id]
  end
end
