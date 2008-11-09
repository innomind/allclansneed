class Site < ActiveRecord::Base
  has_many :guestbooks
  has_many :news_categories
  
  has_many :user_rights
  has_many :users, :through => :user_rights
  has_one :clan
  
  #validates_uniqueness_of :title
end
