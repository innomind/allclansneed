class ForumController < ApplicationController
  def index
    if params[:id].nil?
      @categories = ForumCategory.find_all_by_parent_id(nil)
      if @categories.count == 0
        ForumCategory.create("title" => "root")
      end
    else
      @categories = ForumCategory.find_all_by_parent_id(params[:id])
    end
  end
  
  def create_category
    @category = ForumCategory.find_by_id(params[:id])
    @new_category = @category.children.create(params[:forum_category])
    if @new_category
      return if request.xhr?
    end
  end
  
  def create_category_form
    return if request.xhr? 
  end
end
