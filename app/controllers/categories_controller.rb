class CategoriesController < ApplicationController
  before_filter :fetch_object, :except => [:edit, :update, :destroy]
  before_filter :init_category_by_id, :only => [:edit, :update, :destroy]
  before_filter :init_breadcrumb, :except => [:edit, :update, :destroy]
  before_filter :section_link
  before_filter :init_category_access
  
  def show
    @categories = Category.find :all, :conditions => {:controller => @cat_name, :section => params[:section]}, :order => :position
  end
  
  def newcat
    @category = Category.new
    add_breadcrumb "neue Kategorie"
  end
  
  def create
    @category = Category.new(params[:category])
    @category.controller = @cat_object.class_name
    @section_link = {:section => params[:category][:section]} unless params[:category][:section].empty?
    if @category.save
      flash[:notice] = "Neue Kategorie erstellt"
      
      redirect_to category_path(@cat_name, @section_link)
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
    add_breadcrumb @category.controller, @category.controller.tableize + "_path"
    add_breadcrumb "Kategorien verwalten", category_path(@category.controller)
    add_breadcrumb @category.name + " bearbeiten"    
  end
  
  def update
    if @category.update_attributes(params[:category])
      flash[:notice] = "Kategorie geändert"
      redirect_to category_path(@category.controller)
    else
      render :action => :edit
    end
  end
  
  def destroy
    controller = @category.controller
    flash[:notice] = "Kategorie gelöscht" if @category.destroy
    redirect_to category_path(controller)
  end
  
  private
  
  def section_link
    @section_link = Hash.new
    @section_link = {:section => params[:section]} unless params[:section].nil?
  end
  
  def fetch_object
    begin
      @cat_object = eval(params[:id]) #TODO 
      @cat_name = @cat_object.class_name
    rescue NameError
      raise Exceptions::Access
    end
  end
  
  def init_category_by_id
    @category = Category.find params[:id]
  end
    
  def init_category_access
    raise Exceptions::Access unless current_user.has_right_for? ((@category.nil? ? @cat_name : @category.controller).underscore)
  end
    
  def init_breadcrumb
    #add_breadcrumb @cat_name, @cat_name.tableize + "_path"
    add_breadcrumb "Kategorien verwalten", category_path(@cat_name)
  end
end
