class GalleryCategoryController < ApplicationController
  def index
    @gallery_categories = GalleryCategory.find_for_site(:all)
  end
  
  def show
    @gallery_category = GalleryCategory.find_for_site(:all, :id => params[:id]).first
  end
  
  def new
    
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def delete
    
  end
end
