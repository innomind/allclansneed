class GalleryController < ApplicationController
  
  add_breadcrumb 'Galerie', 'galleries_path'
  
  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES={
    :index => PUBLIC,
    :show => PUBLIC
  }
  
  def index
    @galleries = Gallery.paginate(:all, :include => :gallery_pics)
  end
  
  def show
    @gallery = Gallery.find_by_id params[:id], :include => :gallery_pics
    add_breadcrumb @gallery.name
  end
  
  def new
    add_breadcrumb 'neue Galerie erstellen'
    @gallery = Gallery.new
  end
  
  def create
    add_breadcrumb 'neue Galerie erstellen'    
    @gallery = Gallery.new(params[:gallery])
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
  
  def destroy
    
  end
end
