class Page < ActiveRecord::Base
  acts_as_site
  belongs_to :user
  belongs_to :site
  belongs_to :navigation, :dependent => :destroy
  
  def used_pages
    
  end
  
  def unused_pages
    
  end
end
