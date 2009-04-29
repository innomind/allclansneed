class ForumController < ApplicationController
  
  add_breadcrumb 'Forum', 'forums_path'
  before_filter :authorize, :only => [:edit, :delete]
  
  def index
    @forums = Forum.find(:all)
  end
  
  def show
    @anchor = Forum.find params[:id]
    @threads = @anchor.forum_threads.pages :all
    add_breadcrumb @anchor.title, @anchor
    
    respond_to do |format|
      format.html { render :template => 'forum_thread/index' }
      format.rss { render :layout => false }
    end
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

  private
  def authorize
    
  end
end
