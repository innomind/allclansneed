class ForumThreadController < ApplicationController
  
  #show thread
  def index
    @thread = ForumThread.find_for_site(params[:id]);
    @messages = ForumMessage.page_for_site :conditions => ['forum_thread_id = ?', params[:id]]
  end
  
  #show new thread form
  def new
    @forum_thread = ForumThread.new
    @forum_thread.forum_messages.build
  end
  
  #save new thread
  def create
    @forum = Forum.find_for_site(:first, :conditions => {:id => params[:id]})
    @forum_thread = ForumThread.new(params[:forum_thread])
    @forum_thread.forum = @forum
    @forum_thread.site = current_site
    @forum_thread.user = current_user
    @forum_thread.forum_messages[0].user = current_user
    @forum_thread.forum_messages[0].site = current_site
    if @forum_thread.save
      redirect_to :action => "index", :id => @forum_thread.id
    else
      render :action => "new"
    end
  end
end
