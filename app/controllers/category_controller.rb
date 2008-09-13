class CategoryController < ApplicationController
  
  def list
    @categories = Category.find(:all, :order => "position")
  end
  
  def show
    @category = Category.find(params[:id])
  end

  def new
    @category = Category.new(params[:category])
    if @category.save
      return if request.xhr?  
      render :partial => 'category', :object => @category
    end
  end
  
  def delete
    @category = Category.find(params[:id])
    @category.destroy
    return if request.xhr?
    render :nothing, :status => 200
  end
  
  def update_positions
    params[:category_list].each_with_index do |id, position|
      Category.update(id, :position => position)
    end
    render :nothing => true
  end

end
