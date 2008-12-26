class GalleryController < ApplicationController
  
  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES={
    :index => PUBLIC,
    :show => PUBLIC
  }
  
  def index
    @galleries = Gallery.find_for_site(:all)
  end
  
  def show
    @gallery = Gallery.find_for_site(:first, :conditions => {:id => params[:id]})
  end
  
  def new
    @gallery = Gallery.new
  end
  
  def create
    @gallery = Gallery.new(params[:gallery])
    @gallery.site = current_site
    @gallery.user = current_user
    if @gallery.save
      redirect_to :action => "index"
    else
      render :action => "new"
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def delete
    
  end
end
