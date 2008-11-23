class Group < ActiveRecord::Base
  acts_as_delegatable
  
  has_many :groupmemberships
  has_many :users, :through => :groupmemberships
  
  validates_presence_of :name
  validates_presence_of :founder_id
  
  def founder
    User.find_by_id(self.founder_id)
  end
  
  def founder=(founder)
    self.founder_id = founder.id
  end
end