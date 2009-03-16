class Component < ActiveRecord::Base
  has_many :user_rights
  has_many :user, :through => :user_rights
  has_many :template_box_types
  
  belongs_to :parent, :class_name => "Component", :foreign_key => "parent_id"
  has_many :children, :class_name => "Component", :foreign_key => "parent_id"
  
  def self.get_assoc id
    find id  
  end
end
