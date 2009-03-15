class Component < ActiveRecord::Base
  has_many :right_components
  has_many :user_rights, :through => :right_components
  has_many :template_box_types
  
  def self.get_assoc id
    find id  
  end
end
