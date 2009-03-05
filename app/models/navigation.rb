class Navigation < ActiveRecord::Base
  acts_as_site
  
  belongs_to :site
  belongs_to :template_box
  belongs_to :navigation_template
  
  validates_presence_of :name
end
