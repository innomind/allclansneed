class TemplateBox < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :template_area
  belongs_to :site
  
  #has_many :boxable, :polymorphic => true
end
