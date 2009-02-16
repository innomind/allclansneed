class ForumThreadController < ApplicationController

  CONTROLLER_ACCESS = ACN_MEMBER

  ACTION_ACCESS_TYPES={
    :show => PUBLIC
  }

  add_breadcrumb 'Forum', 'forums_path'
  
  #show thread
  def show
    @thread = ForumThread.find_for_site(params[:id]);
    @messages = ForumMessage.page_for_site :conditions => {:forum_thread_id => @thread}
    
    add_breadcrumb @thread.forum.title, "forum_path(#{@thread.forum.id})"
    add_breadcrumb @thread.title, "forum_thread_path(#{@thread.id})"
  end
  
  #show new thread form
  def new
    @forum = Forum.find_for_site(params[:forum_id])
    add_breadcrumb @forum.title, "forum_path(#{@forum.id})"
    add_breadcrumb "neuer Thread"
    
    @forum_thread = ForumThread.new
    @forum_thread.forum_messages.build
  end
  
  #save new thread
  def create
    @forum = Forum.find_for_site(params[:forum_id])
    @forum_thread = @forum.forum_threads.new(params[:forum_thread])
    @forum_thread.site = current_site
    @forum_thread.user = current_user
    @forum_thread.forum_messages[0].user = current_user
    @forum_thread.forum_messages[0].site = current_site
    if @forum_thread.save
      redirect_to forum_thread_path(@forum_thread.id)
    else
      render :action => "new"
    end
  end
  
  private

end
