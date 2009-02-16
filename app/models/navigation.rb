class Navigation < ActiveRecord::Base
  acts_as_delegatable
  
  belongs_to :template_box
  belongs_to :navigation_template
end
