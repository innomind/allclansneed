class News < ActiveRecord::Base
  acts_as_taggable
  acts_as_delegatable

  belongs_to :user, :foreign_key => "author_id"
  belongs_to :news_category
  
  #deprecated
  has_many :news_comments
  
  has_many :comments
  
  validates_presence_of :title
  validates_presence_of :subtext
  validates_presence_of :news

end