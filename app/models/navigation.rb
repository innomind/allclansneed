class Navigation < ActiveRecord::Base
  belongs_to :template_box
  belongs_to :navigation_template
end
