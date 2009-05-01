module GalleryPicHelper

  def gallery_pic_link_for pic
    #if ActionController::Base.asset_host.empty?
  	#	link_to image_tag(@gallery_pic.pic.url(:medium)), @gallery_pic.pic.url(:original)
  	#else
  		"<a href=\"http://static0.allclansneed.de#{@gallery_pic.pic.url(:original)}\">#{image_tag(@gallery_pic.pic.url(:medium))}</a>"
  	#end
  end

end
