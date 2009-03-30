class Category < ActiveRecord::Base
  acts_as_site
  has_many :news
  belongs_to :site
  
  validates_presence_of :name
  
  def before_save
    self[:section] = nil if self[:section].empty? unless self[:section].nil?
  end
  
  def self.for_select controller, section = nil
    find(:all, :conditions => {:controller => controller, :section => section}, :order => :position).collect{|c| [c.name, c.id]}
  end
  
  def self.global_for_select controller, section = ""
    find(:all, :global => true, :conditions => {:controller => controller, :section => (section.blank? ? nil : section)}, :order => :position).collect{|c| [c.name, c.id]}
  end
end