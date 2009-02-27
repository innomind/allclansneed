class Classified < ActiveRecord::Base
  acts_as_site
  
  belongs_to :site
  belongs_to :user
  has_many :comments, :as => :commentable
end