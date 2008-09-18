class NewsCategory < ActiveRecord::Base
  has_and_belongs_to_many :news
  
  validates_presence_of :name
end
