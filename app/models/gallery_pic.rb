class GalleryPic < ActiveRecord::Base
  acts_as_site
  acts_as_rateable
  
  has_attached_file :pic,
    :styles => {
      :thumb => "100x100#",
      :medium => "300x300>",
      :small  => "150x150>" }
    #,
    #:url => "/upload/:attachment/:id/:style/:basename.:extension",
    #:path => "/mnt/static.allclansneed.de/:attachment/:id/:style/:basename.:extension"
      
  belongs_to :site
  belongs_to :gallery
  belongs_to :user
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates_presence_of :name
end
