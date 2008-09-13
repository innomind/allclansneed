class Page < ActiveRecord::Base
  has_many :categories
  has_many :classifieds
end
