class News < ActiveRecord::Base
  acts_as_taggable
  acts_as_site
  
  belongs_to :user
  belongs_to :news_category
  belongs_to :site
  belongs_to :category
  
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  validates_presence_of :title
  validates_presence_of :subtext
  validates_presence_of :news
  
  def before_update
    n = News.find(id, :include => :comments)
    if n.intern != intern
      n.comments.each do |c| 
        c.intern = intern
        c.save
      end
    end
  end
end