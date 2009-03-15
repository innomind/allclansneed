class SquadController < ApplicationController

  before_filter :init_clan
  before_filter :init_squad, :only => [:edit, :update, :destroy, :confirm_users, :confirm_users_save]
  
  add_breadcrumb 'Squads', "squads_path"
  
  def index
    @squads = @clan.squads.find(:all, :include => :users)
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
    redirect_to squads_path
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
    redirect_to squads_path
  end

  def destroy
    redirect_to(confirm_users_squad_path(@squad)) and return unless @squad.save_destroy_users?
    if @squad.destroy
      flash[:notice] = "Squad gelöscht"
    else
      flash[:error] = "Squad konnte nicht gelöscht werden"
    end
    redirect_to squads_path
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
    @clan = current_site.clan
  end
  
  def init_squad
    @squad = @clan.squads.find params[:id]
  end
end
