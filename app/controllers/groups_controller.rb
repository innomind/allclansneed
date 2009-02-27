class GroupsController < ApplicationController
  
  add_breadcrumb 'Gruppen', "groups_path"
  
  CONTROLLER_ACCESS = PUBLIC

  ACTION_ACCESS_TYPES={
    :new => COMPONENT_RIGHT_OWNER,
    :create => COMPONENT_RIGHT_OWNER,
    :edit => COMPONENT_RIGHT_OWNER,
    :update => COMPONENT_RIGHT_OWNER
  }
  
  def index
    @groups = Group.paginate(:all, :page => params[:page])
  end
  
  def show
    @group = Group.find_by_id(params[:id])
    @active_memberships = Groupmembership.find(:all, :conditions => {:group_id => @group.id, :status => "active"})
    
    @user = current_user
    add_breadcrumb @group.name
  end
  
  def create
    @group = Group.new(params[:group])
    @group.founder = current_user
    
    @membership = Groupmembership.new
    @membership.user = current_user
    
    if @group.save
      @membership.group = @group
      @membership.status = "active"
      @membership.save
      flash[:notice] = "Gruppe erfolgreich angelegt"
      redirect_to :action => 'index'
    else
      flash[:notice] = "Gruppe konnte nicht angelegt werden"
      redirect_to :action => 'new'
    end
  end
  
  def new
    @group = Group.new
    add_breadcrumb 'Gruppe erstellen'
  end
  
  def join
    @group = Group.find_by_id(params[:id])
    @membership = Groupmembership.new
    @membership.user = current_user
    @membership.group = @group
    
    if @group.moderated
      @membership.status = "pending"
    else 
      @membership.status = "active"
    end
    if @membership.save
      flash[:notice] = "Du bist der Gruppe " + @group.name + " beigetreten."
      redirect_to :action => "show", :id => params[:id]
    end
  end
  
  def edit
    @group = Group.find_by_id(params[:id])
    add_breadcrumb "Verwaltung", "administrate_group_path(#{@group.id})"
    add_breadcrumb "bearbeiten"
  end
  
  def update
    @group = Group.find_by_id(params[:id])
    
    if @group.update_attributes(params[:group])
      flash[:notice] = "Deine Gruppe " + @group.name + " wurde erfolgreich aktualisiert."
      redirect_to :action => 'show', :id => @group.id
    else
      flash[:notice] = "Fehler beim aktualisieren der Gruppe " + @group.name
      redirect_to :action => 'edit', :id => @group.id
    end
  end
  
  def administrate
    add_breadcrumb "Verwaltung"
    @group = Group.find_by_id(params[:id])
    
    @pending_memberships = Groupmembership.find(:all, :conditions => {:group_id => @group.id, :status => "pending"})
    @active_memberships = Groupmembership.find(:all, :conditions => ["group_id = ? AND status = ? AND user_id NOT IN (?)", @group.id, "active", current_user.id])
  end
  
  def activate
    @group = Group.find_by_id params[:id]
    @groupmembership = @group.groupmemberships.find_by_id(params[:membership_id])
    @groupmembership.status = "active"
    
    if @groupmembership.save
      flash[:notice] = "Du hast " + @groupmembership.user.login + " freigeschalten."
    else
      flash[:notice] = "Es ist ein Fehler beim freischalten von " + @groupmembership.user.login + " aufgetreten."
    end
    redirect_to :action => "administrate", :id => @groupmembership.group.id
  end
  
  def kick
    @group = Group.find_by_id params[:id]
    @groupmembership = @group.groupmemberships.find_by_id(params[:membership_id])
    if @groupmembership.destroy
      flash[:notice] = "Du hast " + @groupmembership.user.login + " aus der Gruppe geworfen."
      redirect_to :action => "administrate", :id => @groupmembership.group.id
    end
  end
end