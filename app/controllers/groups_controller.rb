class GroupsController < ApplicationController
  def index
    @groups = Group.find(:all)
  end
  
  def show
    @group = Group.find_by_id(params[:id])
    @user = current_user
  end
  
  def create
    @group = Group.new(params[:group])
    @group.founder = current_user
    
    if @group.save
      flash[:notice] = "Gruppe erfolgreich angelegt"
      redirect_to :action => 'index'
    else
      flash[:notice] = "Gruppe konnte nicht angelegt werden" + params[:group][:moderated]
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
  
  def update
    
  end
  
  def save
    
  end
end