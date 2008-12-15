class TemplateBox < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :template_area
  belongs_to :site
  belongs_to :template_box_type
  
  has_many :navigations
  
  validates_presence_of :name
end
