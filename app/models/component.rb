class Component < ActiveRecord::Base
  has_many :user_rights
  has_many :user, :through => :user_rights
  has_many :template_box_types
  
  def self.get_assoc id
    find id  
  end
end
