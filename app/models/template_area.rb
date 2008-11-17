class TemplateArea < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :template
  has_many :template_boxes
  has_many :sites, :through => :template_boxes
end