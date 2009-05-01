class Profile < ActiveRecord::Base
  #acts_as_delegatable
  
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  
end