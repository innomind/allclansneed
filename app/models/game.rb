class Game < ActiveRecord::Base
  has_and_belongs_to_many :squads
  has_and_belongs_to_many :profiles
  has_many :clans, :through => :squads
end
