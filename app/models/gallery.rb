class Gallery < ActiveRecord::Base
  #acts_as_delegatable
  acts_as_site

  belongs_to :site
  belongs_to :user
  has_many :gallery_pics
  
  
  def category_pic
    return_pic = self.gallery_pics.first
    unless return_pic.nil?
      return_pic.pic
    end
  end
end
