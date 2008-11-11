class GalleryCategory < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :site
  belongs_to :user
  has_many :gallery_pics
end
