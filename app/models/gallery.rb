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
  
  def before_update
    g = Gallery.find(id, :include => {:gallery_pics => :comments})
    if g.intern != intern
      g.gallery_pics.each do |p| 
        p.intern = intern
        p.save
        p.comments.each do |c|
          c.intern = intern
          c.save
        end
      end
    end
  end
end
