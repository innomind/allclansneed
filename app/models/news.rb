class News < ActiveRecord::Base
  acts_as_taggable
  acts_as_delegatable

  belongs_to :user
  belongs_to :news_category
  belongs_to :site
  
  #deprecated
  has_many :news_comments
  
  has_many :comments
  
  validates_presence_of :title
  validates_presence_of :subtext
  validates_presence_of :news

end