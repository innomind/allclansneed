class GalleryPicController < ApplicationController
  add_breadcrumb 'Gallerie', "galleries_path"
  before_filter :init_gallery, :only => [:new, :create]
  
  def show
    @gallery_pic = GalleryPic.find params[:id], :joins => :gallery
    @next_pic = @gallery_pic.gallery.gallery_pics.find :first, :conditions => ["created_at > ?", @gallery_pic.created_at]
    @prev_pic = @gallery_pic.gallery.gallery_pics.find :first, :conditions => ["created_at < ?", @gallery_pic.created_at]
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

  def destroy
    @gallery_pic = GalleryPic.find(params[:id])
    help = @gallery_pic.gallery_id
    @gallery_pic.pic = nil
    @gallery_pic.save
    if @gallery_pic.destroy
      flash[:notice] = "Bild gelöscht"
      redirect_to gallery_path(help)
    else
      flash[:notice] = "Bild nicht gelöscht"
      render :action => "new"
    end
  end

  def update
    @gallery_pic = GalleryPic.find params[:id]
    if @gallery_pic.update_attributes(params[:gallery_pic])
      @gallery_pic.save
      flash[:notice] = "Bild erfolgreich geändert"
      redirect_to gallery_path(@gallery_pic.gallery_id)
    else
      flash[:notice] = "Bild nicht geändert"
      render :action => "edit"
    end
  end

  def edit
    @gallery_pic = GalleryPic.find params[:id]
    add_breadcrumb "Bild editieren"
  end

  private
  def init_gallery
    @gallery = Gallery.find(params[:gallery_id])
    add_breadcrumb @gallery.name, "gallery_path(#{@gallery.id})"
  end
end
