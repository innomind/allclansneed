class GalleryPicController < ApplicationController
  def show
    @gallery_pic = GalleryPic.find_for_site(params[:id])
  end
  
  def new
    @gallery = Gallery.find_for_site(params[:id])
    @gallery_pic = GalleryPic.new
  end
  
  def create
    @gallery = Gallery.find_for_site(params[:id])
    @gallery_pic = GalleryPic.new(params[:gallery_pic])
    @gallery_pic.gallery = @gallery
    @gallery_pic.user = current_user
    @gallery_pic.site = current_site
    if @gallery_pic.save
      redirect_to :controller => "gallery", :action => "show", :id => params[:id] 
    else
      render :action => "new"
    end
  end
end
