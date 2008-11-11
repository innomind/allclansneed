class GalleryPic < ActiveRecord::Base
  acts_as_delegatable
  
  has_attached_file :pic,
    :styles => {
      :thumb=> "100x100#",
      :small  => "150x150>" }

  belongs_to :site
  belongs_to :gallery
  belongs_to :user
  
  has_many :comments
end
