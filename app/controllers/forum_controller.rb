class ForumController < ApplicationController
  
  #
  # show index and categories
  #
  
  def index
    if params[:id].nil?
      @categories = ForumCategory.find_all_by_parent_id(nil)
      if @categories.count == 0
        ForumCategory.create("title" => "root")
      end
    else
      @subcategories = ForumCategory.find_all_by_parent_id(params[:id])
      @category = ForumCategory.find(params[:id])
      @threads = ForumThread.find(:all, :conditions => {:forum_category_id => params[:id]})
      render :template => "forum/category"
    end
  end
  
  #
  # Category Create, Update, Delete Functions
  #
  def new_category
    return if request.xhr? 
  end
  
  def create_category
    @category = ForumCategory.find_by_id(params[:id])
    @new_category = @category.children.create(params[:forum_category])
    if @new_category
      return if request.xhr?
    end
  end
  
  def edit_category
    @category = ForumCategory.find_by_id(params[:id])
  end
  
  def update_category
    @category = ForumCategory.find_by_id(params[:id])
    if @category.update_attributes(params[:forum_category])
    end
  end
  
  def delete_category_form
    return if request.xhr?
  end
  
  #
  # Thread Functions
  #
  
  #show thread
  def thread
    @thread = ForumThread.find(params[:id]);
    @messages = ForumMessage.find(:all, :conditions => { :forum_thread_id => params[:id] } )
  end
  
  #show new thread form
  def new_thread
    @forum_thread = ForumThread.new
    @forum_thread.forum_messages.build
  end
  
  #save new thread
  def create_thread
    @forum_thread = ForumThread.new(params[:forum_thread])
    @forum_thread.forum_category_id = params[:id]
    @forum_thread.account_id = current_user_id
    @forum_thread.forum_messages[0].account_id = current_user_id
    if @forum_thread.save
      redirect_to :action => "thread", :id => @forum_thread.id
    else
      render :action => "new_thread"
    end
  end
end