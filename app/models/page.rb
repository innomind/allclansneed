class Page < ActiveRecord::Base
  acts_as_site
  belongs_to :user
  belongs_to :site
  belongs_to :navigation, :dependent => :destroy
  
  def self.pages_free?
    !!find(:all, :select => "count(*)", :conditions => {:navigation_id => nil}).size
  end
end
