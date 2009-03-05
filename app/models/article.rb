class Article < ActiveRecord::Base
  acts_as_site
  acts_as_rateable

  validates_presence_of :title
  validates_presence_of :content
  belongs_to :user
  belongs_to :site
  has_many :comments, :as => :commentable
end
