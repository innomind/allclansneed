class TemplateArea < ActiveRecord::Base
  belongs_to :template
  has_many :template_boxes
end
