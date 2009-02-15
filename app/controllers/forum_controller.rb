class ForumController < ApplicationController
  
  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES={
    :index => PUBLIC,
    :show => PUBLIC
  }
  
  add_breadcrumb 'Forum', 'forums_path'
  
  def index
    @forums = Forum.find_for_site(:all)
  end
  
  def show
    @forum = Forum.find_for_site :first, :conditions => { :id => params[:id]}
    @threads = ForumThread.page_for_site :all, :conditions => {:forum_id => params[:id]}
    add_breadcrumb @forum.title, ''
  end
  
  def new
    @forum = Forum.new
  end
  
  def create
    @forum = Forum.new(params[:forum])
    @forum.site = current_site
    if @forum.save
      flash[:notice] = "Forum erfolgreich erstellt"
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end
  
  def edit
    @forum = Forum.find_for_site_by_id(params[:id])
  end
  
  def update
    @forum = Forum.find_for_site_by_id(params[:id])
    if @forum.update_attributes(params[:forum])
      flash[:notice] = "Forum erfolgreich geändert"
      redirect_to forums_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    Forum.find_for_site_by_id(params[:id]).destroy if flash[:notice] = "Forum gelöscht"
    redirect_to forums_path
  end
end
