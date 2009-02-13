class ForumController < ApplicationController
  
  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES={
    :index => PUBLIC,
    :show => PUBLIC
  }
  
  def index
    #git test
    if params[:id].nil?
      @forums = Forum.find_for_site(:all)
    else
      #@subforums = Forum.find_for_site(:all, :conditions => {:parent_id => params[:id]} )
      @forum = Forum.find_for_site(:first, :conditions => { :id => params[:id]})
      @threads = ForumThread.find_for_site(:all, :conditions => {:forum_id => params[:id]})
      render :template => "forum/forum"
    end
  end
  
  def new
    @forum = Forum.new
  end
  
  def create
    @forum = Forum.new(params[:forum])
    @forum.site = current_site
    if @forum.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end
  
  def edit
    @category = Forum.find_for_site_by_id(params[:id])
  end
  
  def update
    @category = Forum.find_for_site_by_id(params[:id])
    if @category.update_attributes(params[:forum_category])
    end
  end
  
  def delete
    return if request.xhr?
  end
end
