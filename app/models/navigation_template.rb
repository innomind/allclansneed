class NavigationTemplate < ActiveRecord::Base
  has_many :navigations
  
  def self.used_types
    Navigation.all.collect{|n| n.navigation_template_id }.compact
  end
  
  def self.unused_types
    used = self.used_types
    conditions = ["id NOT IN (?)", used] unless used.empty?
    find :all, :conditions => conditions
  end
  
  def self.templates_free?
    self.unused_types.size > 0 ? true : false
  end
end
