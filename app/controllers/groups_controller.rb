class GroupsController < ApplicationController
  def index
    @groups = Group.find(:all)
  end
  
  def show
    @group = Group.find_by_id(params[:id])
  end
  
  def create
    @group = Group.new(params[:group])
    if @group.save
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
  
  def update
    
  end
  
  def save
    
  end
end