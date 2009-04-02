class Group < ActiveRecord::Base
  
  has_many :groupmemberships
  has_many :users, :through => :groupmemberships
  belongs_to :founder, :class_name => "User", :foreign_key => :founder_id
  
  has_many :forum_threads, :as => :threadable, :dependent => :destroy
  
  validates_presence_of :name
  validates_presence_of :founder_id
  
  has_attached_file :group_pic,
    :styles => {
      :thumb => "100x100#" }
  
  def founder
    User.find_by_id(self.founder_id)
  end
  
  def founder=(founder)
    self.founder_id = founder.id
  end
  
  def title
    self.name
  end
end