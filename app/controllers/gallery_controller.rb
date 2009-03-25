class GalleryController < ApplicationController
  
  add_breadcrumb 'Galerie', 'galleries_path'
  
  def index
    @galleries = Gallery.paginate(:all, :include => :gallery_pics)
  end
  
  def show
    @gallery = Gallery.find_by_id params[:id], :include => :gallery_pics
    @gallery_pics = @gallery.gallery_pics.pages
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
    @gallery = Gallery.find params[:id]
    add_breadcrumb "Gallerie bearbeiten"
  end
  
  def update
    @gallery = Gallery.find params[:id]
    if @gallery.update_attributes params[:gallery]
      flash[:notice] = "Galerie geändert"
      redirect_to gallery_path(@gallery)
    else
      flash[:notice] = "Änderung gescheitert"
      redirect_to gallery_path(@gallery)
    end
  end
  
  def destroy
    @gallery = Gallery.find params[:id]
    @gallery_pics = @gallery.gallery_pics

    @gallery_pics.each do |gallery_pic|
      unless gallery_pic.destroy
        flash[:notice] = "Galerie konnte nicht gelöscht werden"
        redirect_to gallery_path(@gallery)
      end
    end
    
    if @gallery.destroy
      flash[:notice] = "Galerie erfolgreich gelöscht"
      redirect_to root_path
    end
  end
end
