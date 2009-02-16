class Template < ActiveRecord::Base
  acts_as_delegatable
  has_many :sites
  has_many :template_areas, :dependent => :destroy
end
