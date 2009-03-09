class ForumMessageController < ApplicationController
  
  CONTROLLER_ACCESS = ACN_MEMBER
  
  before_filter :init_thread
    
  def new
    @forum_message = ForumMessage.new
  end
  
  def create
    @forum_message = @forum_thread.forum_messages.new(params[:forum_message])
    if @forum_message.save
      redirect_to forum_thread_path(@forum_thread)
    else
      render :action => "new"
    end
  end
  
  private
  def init_thread
    @forum_thread = ForumThread.find(params[:forum_thread_id])
    add_breadcrumb @forum_thread.anchor.class.human_name, "#{@forum_thread.anchor.class.name.tableize}_path"
    add_breadcrumb @forum_thread.anchor.title, @forum_thread.anchor
    add_breadcrumb "Threads", [@forum_thread.anchor, "forum_threads"] unless @forum_thread.anchor.class == Forum
    add_breadcrumb @forum_thread.title, @forum_thread
    add_breadcrumb 'Neuer Post'
  end
end