class ForumController < ApplicationController
  
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
  
  def new
    return if request.xhr? 
  end
  
  def create
    @category = ForumCategory.find_by_id(params[:id])
    @new_category = @category.children.create(params[:forum_category])
    if @new_category
      return if request.xhr?
    end
  end
  
  def edit
    @category = ForumCategory.find_by_id(params[:id])
  end
  
  def update
    @category = ForumCategory.find_by_id(params[:id])
    if @category.update_attributes(params[:forum_category])
    end
  end
  
  def delete
    return if request.xhr?
  end
end
