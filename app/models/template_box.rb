class TemplateBox < ActiveRecord::Base
  acts_as_site
  belongs_to :template_area
  belongs_to :site
  belongs_to :template_box_type
  
  has_many :navigations, :dependent => :destroy
  
  validates_presence_of :name
end
