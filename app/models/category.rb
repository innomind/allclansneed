class Category < ActiveRecord::Base
  has_many :classifieds, :dependent => :nullify
  belongs_to :page
  #validates_uniqueness_of :name, :scope => "page_id"
end
