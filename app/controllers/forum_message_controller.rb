class ForumMessageController < ApplicationController
  
  CONTROLLER_ACCESS = ACN_MEMBER
  
  def new
    @forum_thread = ForumThread.find_for_site(params[:forum_thread_id])
    add_breadcrumb 'Forum', "forums_path"
    add_breadcrumb @forum_thread.forum.title, "forum_path(#{@forum_thread.forum.id})"
    add_breadcrumb @forum_thread.title, "forum_thread_path(#{@forum_thread.id})"
    add_breadcrumb 'Neuer Post', ''
    @forum_message = ForumMessage.new
  end
  
  def create
    @forum_thread = ForumThread.find_for_site(params[:forum_thread_id])
    @forum_message = @forum_thread.forum_messages.new(params[:forum_message])
    @forum_message.user = current_user
    @forum_message.site = current_site
    if @forum_message.save
      redirect_to forum_thread_path(@forum_thread)
    else
      render :action => "new"
    end
  end
end