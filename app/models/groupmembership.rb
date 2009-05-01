class Groupmembership < ActiveRecord::Base
  belongs_to :user
  belongs_to :group, :counter_cache => true
  
  validates_presence_of :status
  validates_presence_of :group_id
  validates_presence_of :user_id
end
