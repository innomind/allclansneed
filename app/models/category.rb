class Category < ActiveRecord::Base
  has_many :classifieds, :dependent => :nullify
  belongs_to :site
  #validates_uniqueness_of :name, :scope => "page_id"
end
