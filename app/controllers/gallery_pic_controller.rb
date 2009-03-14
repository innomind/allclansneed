class GalleryPicController < ApplicationController
  add_breadcrumb 'Gallerie', "galleries_path"
  before_filter :init_gallery, :only => [:new, :create]
  
  def show
    @gallery_pic = GalleryPic.find(params[:id])
    add_breadcrumb @gallery_pic.gallery.name, "gallery_path(#{@gallery_pic.gallery.id})"
    add_breadcrumb @gallery_pic.name
  end
  
  def new
    add_breadcrumb 'Bild hochladen'
    @gallery_pic = GalleryPic.new
  end
  
  def create
    add_breadcrumb 'Bild hochladen'
    @gallery_pic = @gallery.gallery_pics.new(params[:gallery_pic])
    @gallery_pic.intern = @gallery.intern
    if @gallery_pic.save
      flash[:notice] = "Bild hochgeladen"
      redirect_to pic_path(@gallery_pic) 
    else
      render :action => "new"
    end
  end
  
  private
  def init_gallery
    @gallery = Gallery.find(params[:gallery_id])
    add_breadcrumb @gallery.name, "gallery_path(#{@gallery.id})"
  end
end
