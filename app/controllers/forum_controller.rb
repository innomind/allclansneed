class ForumController < ApplicationController
  
  def index
    #git test
    if params[:id].nil?
      @forums = Forum.find_for_site(:all, :conditions => {:parent_id => nil} )
      if @forums.empty?
        newforum = Forum.new(:title => "root")
        newforum.site = current_site
        newforum.save
      end
    else
      @subforums = Forum.find_for_site(:all, :conditions => {:parent_id => params[:id]} )
      @forum = Forum.find_for_site(:first, :conditions => { :id => params[:id]})
      @threads = ForumThread.find_for_site(:all, :conditions => {:forum_id => params[:id]})
      render :template => "forum/forum"
    end
  end
  
  def new
    return if request.xhr? 
  end
  
  def create
    @forum = Forum.find_for_site_by_id(params[:id])
    @new_forum = @forum.children.new(params[:forum])
    @new_forum.site = current_site
    if @new_forum.save
      return if request.xhr?
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
