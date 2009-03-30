class ClanwarMap < ActiveRecord::Base
  belongs_to :clanwar
  attr_accessor :should_destroy
  
  validates_presence_of :score
  validates_presence_of :score_opponent
  validates_presence_of :name
  validates_numericality_of :score
  validates_numericality_of :score_opponent
  
  def should_destroy?
    should_destroy.to_i == 1
  end
end
