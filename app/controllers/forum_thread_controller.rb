class ForumThreadController < ApplicationController

  CONTROLLER_ACCESS = ACN_MEMBER

  ACTION_ACCESS_TYPES={
    :show => PUBLIC,
    :index => PUBLIC
  }

  before_filter :init_thread, :except => [:show] 
  
  def index
    @threads = @anchor.forum_threads.pages :all
    add_breadcrumb @anchor.title, ''
  end
  
  #show thread
  def show
    @thread = ForumThread.find(params[:id]);
    @messages = ForumMessage.paginate :conditions => {:forum_thread_id => @thread}
    
    add_breadcrumb @thread.anchor.class.name, "#{@thread.threadable_type.tableize}_path"
    add_breadcrumb @thread.anchor.title, "forum_path(#{@thread.forum.id})"
    add_breadcrumb @thread.title, "forum_thread_path(#{@thread.id})"
  end
  
  #show new thread form
  def new
    add_breadcrumb "neuer Thread"
    @forum_thread = @anchor.forum_threads.new
    @forum_thread.forum_messages.build
  end
  
  #save new thread
  def create
    @forum_thread = @anchor.forum_threads.new(params[:forum_thread])
    @forum_thread.forum_messages[0].user = current_user
    @forum_thread.forum_messages[0].site = current_site
    if @forum_thread.save
      redirect_to forum_thread_path(@forum_thread.id)
    else
      render :action => "new"
    end
  end
  
  private
  def init_thread
    @anchor = Forum.find(params[:forum_id]) unless params[:forum_id].nil?    
    @anchor = Group.find(params[:group_id]) unless params[:group_id].nil?
  end
  
end
