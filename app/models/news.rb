class News < ActiveRecord::Base
  acts_as_taggable
  acts_as_delegatable

  belongs_to :account, :foreign_key => "author_id"
  has_many :news_comments
  
  validates_presence_of :title
  validates_presence_of :subtext
  validates_presence_of :news

end