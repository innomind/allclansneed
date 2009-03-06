class ForumController < ApplicationController
  
  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES={
    :index => PUBLIC,
    :show => PUBLIC
  }
  
  add_breadcrumb 'Forum', 'forums_path'
  
  def index
    @forums = Forum.find(:all)
  end
    
  def new
    @forum = Forum.new
    add_breadcrumb 'Forum erstellen'
  end
  
  def create
    add_breadcrumb 'Forum erstellen'
    @forum = Forum.new(params[:forum])
    if @forum.save
      flash[:notice] = "Forum erfolgreich erstellt"
      redirect_to forums_path
    else
      render :action => "new"
    end
  end
  
  def edit
    @forum = Forum.find_by_id(params[:id])
    add_breadcrumb 'Forum Editieren', ''
  end
  
  def update
    @forum = Forum.find_by_id(params[:id])
    if @forum.update_attributes(params[:forum])
      flash[:notice] = "Forum erfolgreich geändert"
      redirect_to forums_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    Forum.find_by_id(params[:id]).destroy if flash[:notice] = "Forum gelöscht"
    redirect_to forums_path
  end
end
