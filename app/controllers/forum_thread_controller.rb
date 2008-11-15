class ForumThreadController < ApplicationController
  
  #show thread
  def index
    @thread = ForumThread.find(params[:id]);
    @messages = ForumMessage.search(params[:id], params[:page])
  end
  
  #show new thread form
  def new
    @forum_thread = ForumThread.new
    @forum_thread.forum_messages.build
  end
  
  #save new thread
  def create
    @forum = Forum.find_for_site(:first, :forum_id => params[:id])
    @forum_thread = ForumThread.new(params[:forum_thread])
    @forum_thread.forum = @forum
    @forum_thread.user = current_user
    @forum_thread.forum_messages[0].user = current_user
    if @forum_thread.save
      redirect_to forum_thread_path(current_site_id, @forum_thread.id)
    else
      render :action => "new"
    end
  end
end
