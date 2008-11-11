class GalleryController < ApplicationController
  def index
    @galleries = Gallery.find_for_site(:all)
  end
  
  def show
    @galleries = Gallery.find_for_site(:all, :id => params[:id]).first
  end
  
  def new
    @gallery = Gallery.new
  end
  
  def create
    @gallery = Gallery.new(params[:gallery])
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def delete
    
  end
end
