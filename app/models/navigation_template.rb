class NavigationTemplate < ActiveRecord::Base
  has_many :navigations
  
  def self.used_types
    Navigation.all.collect{|n| n.navigation_template_id }
  end
  
  def self.unused_types
    find :all, :conditions => ["id NOT IN (?)", self.used_types]
  end
  
  def self.templates_free?
    self.unused_types.size > 0 ? true : false
  end
end
