class ForumMessageController < ApplicationController
   def new
    @forum_message = ForumMessage.new
  end
  
  def create
    @forum_message = ForumMessage.new(params[:forum_message])
    @forum_message.forum_thread_id = params[:id]
    @forum_message.user = current_user
    if @forum_message.save
      redirect_to :controller => "forum_thread", :action => "index", :id => params[:id]
    else
      render :action => "new"
    end
  end
end
