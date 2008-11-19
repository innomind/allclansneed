class Template < ActiveRecord::Base
  belongs_to :site
  has_many :template_areas
end
