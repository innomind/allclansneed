class GroupsController < ApplicationController
  def index
    @groups = Group.find(:all)
  end
  
  def show
    @group = Group.find_by_id(params[:id])
    @active_memberships = Groupmembership.find(:all, :conditions => {:group_id => @group.id, :status => "active"})
    
    @user = current_user
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
    @group = Group.find_by_id(params[:id])
    
    @pending_memberships = Groupmembership.find(:all, :conditions => {:group_id => @group.id, :status => "pending"})
    @active_memberships = Groupmembership.find(:all, :conditions => {:group_id => @group.id, :status => "active"})
  end
  
  def activate
    @groupmembership = Groupmembership.find_by_id(params[:id])
    @groupmembership.status = "active"
    
    if @groupmembership.save
      flash[:notice] = "Du hast " + @groupmembership.user.login + " freigeschalten."
    else
      flash[:notice] = "Es ist ein Fehler beim freischalten von " + @groupmembership.user.login + " aufgetreten."
    end
    redirect_to :action => "administrate", :id => @groupmembership.group.id
  end
  
  def kick
    @groupmembership = Groupmembership.find_by_id(params[:id])
    if @groupmembership.destroy
      flash[:notice] = "Du hast " + @groupmembership.user.login + " aus der Gruppe geworfen."
      redirect_to :action => "administrate", :id => @groupmembership.group.id
    end
  end
end