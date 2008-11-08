class Squad < ActiveRecord::Base
  
  belongs_to :clan
  has_many :squad_users
  has_many :users, :through => :squad_users
end
