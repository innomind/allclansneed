class TemplateBoxType < ActiveRecord::Base
  has_many :template_boxes
  has_one :template_area
  belongs_to :component
end
