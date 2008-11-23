class Group < ActiveRecord::Base
  acts_as_delegatable
  
  has_many :groupmemberships
  has_many :users, :through => :groupmemberships
  
  validates_presence_of :name
end
