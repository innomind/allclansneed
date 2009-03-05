class ForumThreadController < ApplicationController

  CONTROLLER_ACCESS = ACN_MEMBER

  ACTION_ACCESS_TYPES={
    :show => PUBLIC
  }

  before_filter :init_thread
  
  #show thread
  def show
    @thread = ForumThread.find(params[:id]);
    @messages = ForumMessage.paginate :conditions => {:forum_thread_id => @thread}
    
    add_breadcrumb @thread.forum.title, "forum_path(#{@thread.forum.id})"
    add_breadcrumb @thread.title, "forum_thread_path(#{@thread.id})"
  end
  
  #show new thread form
  def new
    unless params[:forum_id].nil?
      @anchor = Forum.find(params[:forum_id])
      add_breadcrumb 'Forum', 'forums_path'
      add_breadcrumb @anchor.title, "forum_path(#{@anchor.id})"
      @forum_thread = @anchor.forum_threads.new
    end
    unless params[:group_id].nil?
      @anchor = Group.find(params[:group_id])
      add_breadcrumb 'Gruppen', 'groups_path'
      add_breadcrumb @anchor.name, "group_path(#{@anchor.id})"
      @forum_thread = @anchor.threads.new
    end
    add_breadcrumb "neuer Thread"
    
    @forum_thread.forum_messages.build
  end
  
  #save new thread
  def create

    unless params[:forum_id].nil?
      @forum = Forum.find(params[:forum_id])
      @forum_thread = @forum.forum_threads.new(params[:forum_thread])
    end
    unless params[:group_id].nil?
      @group = Group.find(params[:group_id])
      @forum_thread = @group.threads.new(params[:forum_thread])
    end

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
    unless params[:forum_id].nil?
      add_breadcrumb 'Forum', "forums_path"
    end
    
    unless params[:group_id].nil?
      add_breadcrumb 'Gruppen', 'groups_path'
    end
  end
  
end
