class TemplateBoxType < ActiveRecord::Base
  has_many :template_boxes
  belongs_to :component
end
