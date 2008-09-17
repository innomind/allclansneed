class News < ActiveRecord::Base
  belongs_to :account, :foreign_key => "author_id"
  belongs_to :news_category
  has_many :news_comments
  
  validates_presence_of :title
  validates_presence_of :subtext
  validates_presence_of :news
end