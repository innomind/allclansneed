class Category < ActiveRecord::Base
  acts_as_site
  has_many :news
  
  validates_presence_of :name
  
  def self.for_select controller
    find(:all, :conditions => {:controller => controller}, :order => :position).collect{|c| [c.name, c.id]}
  end
end
