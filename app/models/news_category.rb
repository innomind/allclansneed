class NewsCategory < ActiveRecord::Base
  has_many :news
  
  validates_presence_of :name
end
