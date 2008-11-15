class Clanwar < ActiveRecord::Base
  
  acts_as_delegatable
  has_many :clanwarmaps
  has_many :comments, :as => :commentable
  belongs_to :squad
  belongs_to :site
end
