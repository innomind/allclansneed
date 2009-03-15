class SquadUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :squad
  
end
