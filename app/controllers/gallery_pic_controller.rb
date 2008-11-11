class GalleryPicController < ApplicationController
  def new
    @gallery_pic = GalleryPic.new
  end
  
  def create
    @gallery_pic = GalleryPic.new(params[:gallery_pic])
    if @gallery_pic.save
      
    end
  end
end
