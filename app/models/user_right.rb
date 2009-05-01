class UserRight < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :site
  belongs_to :component
  #has_many :right_components
  #has_many :components, :through => :right_components
end
