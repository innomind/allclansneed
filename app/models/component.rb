class Component < ActiveRecord::Base
  has_many :right_components
  has_many :user_rights, :through => :right_components
end
