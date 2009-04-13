class Page < ActiveRecord::Base
  acts_as_site
  belongs_to :user
  belongs_to :site
  belongs_to :navigation, :dependent => :destroy

  validates_site_uniqueness_of :title, :on => :create
  
  def self.pages_free?
    !!find(:all, :select => "count(*)", :conditions => {:navigation_id => nil}).size
  end
  
  #def to_param
  #  title
  #end

end
