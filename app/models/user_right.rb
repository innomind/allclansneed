class UserRight < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :site
  has_many :right_components
  has_many :components, :through => :right_components
  
  validates_presence_of :right_type
end
