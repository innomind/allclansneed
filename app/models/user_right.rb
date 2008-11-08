class UserRight < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :site
  
  validates_presence_of :level
end
