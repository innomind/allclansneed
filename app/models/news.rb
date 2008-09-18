class News < ActiveRecord::Base
  has_and_belongs_to_many :news_categories
  belongs_to :account, :foreign_key => "author_id"
  has_many :news_comments
  
  validates_presence_of :title
  validates_presence_of :subtext
  validates_presence_of :news
end