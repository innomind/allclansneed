class SquadUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :squad, :counter_cache => true
  has_one :clan, :through => :squad
  #belongs_to :role, :class_name => "Category", :foreign_key => "role_id"
end
