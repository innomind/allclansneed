class CategoriesController < ApplicationController
  before_filter :fetch_object, :except => [:edit, :update]
  before_filter :init_category, :except => [:edit, :update]
  
  def show
    @categories = Category.find :all, :conditions => {:controller => @cat_name}, :order => :position
  end
  
  def newcat
    @category = Category.new
    add_breadcrumb "neue Kategorie"
  end
  
  def create
    @category = Category.new(params[:category])
    @category.controller = @cat_object.class_name
    if @category.save
      flash[:notice] = "Neue Kategorie erstellt"
      redirect_to category_path(@cat_name)
    else
      render :action => :new
    end
  end
  
  def update_positions
   params["categories"].each_with_index do |id, position|
     Category.update(id, :position => position)
   end
   render :nothing => true
  end
  
  def edit
    @category = Category.find_by_id params[:id]
    add_breadcrumb @category.controller, @category.controller.tableize + "_path"
    add_breadcrumb "Kategorien verwalten", category_path(@category.controller)
    add_breadcrumb @category.name + " bearbeiten"    
  end
  
  def update
    @category = Category.find_by_id params[:id]
    if @category.update_attributes(params[:category])
      flash[:notice] = "Kategorie geändert"
      redirect_to category_path(@category.controller)
    else
      render :action => :edit
    end
  end
  
  private
  
  def fetch_object
    begin
      @cat_object = eval(params[:id])
      @cat_name = @cat_object.class_name
    rescue NameError
      render :layout => true, :text => "ups" and return
    end
  end
  
  def init_category
    add_breadcrumb @cat_name, @cat_name.tableize + "_path"
    add_breadcrumb "Kategorien verwalten", category_path(@cat_name)
  end
end
