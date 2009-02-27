class Group < ActiveRecord::Base
  
  has_many :groupmemberships
  has_many :users, :through => :groupmemberships
  belongs_to :founder, :class_name => "User", :foreign_key => :founder_id
  
  validates_presence_of :name
  validates_presence_of :founder_id
  
  def founder
    User.find_by_id(self.founder_id)
  end
  
  def founder=(founder)
    self.founder_id = founder.id
  end
end