class Site < ActiveRecord::Base
  has_many :categories
  has_many :classifieds
  has_many :guestbooks
end