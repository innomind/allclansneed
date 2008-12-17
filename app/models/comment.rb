class Comment < ActiveRecord::Base
  
  acts_as_delegatable
  
  belongs_to :user
  belongs_to :news
  belongs_to :site
  belongs_to :commentable, :polymorphic => true
end
