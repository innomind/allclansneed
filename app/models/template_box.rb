class TemplateBox < ActiveRecord::Base
  belongs_to :template_areas
  belongs_to :site
  
  
end
