class NewsCategoryController < ApplicationController
  #  ACTION_ACCESS_TYPES = {:all => User::COMPONENT_RIGHT_OWNER}
  CONTROLLER_ACCESS = User::COMPONENT_RIGHT_OWNER
  
  def index
    redirect_to :action => "list"
  end
  
  def list
    @catgories = NewsCategory.all
  end
  
  def show
    @category = NewsCategory.find(params[:id])
  end
  
  def new
    @category = NewsCategory.new
  end
  
  def create
    @category = NewsCategory.new(params[:news_category])
    
    if @category.save
      redirect_to :action => "list"
    else
      render :action  => "new"
    end
  end
  
  def delete
    
  end
end
