class ForumThreadController < ApplicationController

  before_filter :init_thread, :except => [:show] 
  before_filter :init_show, :only => [:show]
  before_filter :init_breadcrumb
  
  def index
    @threads = @anchor.forum_threads.pages :all
  end
  
  #show thread
  def show
    asdfasdf-.asdf.
    @messages = ForumMessage.paginate :conditions => {:forum_thread_id => @thread}, :order => "created_at ASC"
    add_breadcrumb @thread.title
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
    @forum_thread.forum_messages[0].intern = @anchor.intern if @anchor.methods.include?("intern")
    @forum_thread.intern = @anchor.intern if @anchor.methods.include?("intern")
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
  
  def init_show
    @thread = ForumThread.find(params[:id])
    @anchor = @thread.anchor
  end
  
  def init_breadcrumb
    add_breadcrumb @anchor.class.human_name, "#{@anchor.class.name.tableize}_path"
    add_breadcrumb @anchor.title, @anchor
    add_breadcrumb "Threads", [@anchor, "forum_threads"] unless @anchor.class == Forum
  end
  
end
