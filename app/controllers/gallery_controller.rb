class GalleryController < ApplicationController
  
  add_breadcrumb 'Galerie', 'galleries_path'
  
  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES={
    :index => PUBLIC,
    :show => PUBLIC
  }
  
  def index
    @galleries = Gallery.find_for_site(:all)
  end
  
  def show
    @gallery = Gallery.find_for_site_by_id params[:id]
    add_breadcrumb @gallery.name
  end
  
  def new
    add_breadcrumb 'neue Galerie erstellen'
    @gallery = Gallery.new
  end
  
  def create
    @gallery = Gallery.new(params[:gallery])
    @gallery.site = current_site
    @gallery.user = current_user
    if @gallery.save
      flash[:notice] = "Gallerie erstellt"
      redirect_to new_gallery_pic_path(@gallery)
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
