class Comment < ActiveRecord::Base
  
  #acts_as_delegatable
  acts_as_site
  
  belongs_to :user
  belongs_to :site
  belongs_to :commentable, :polymorphic => true
end