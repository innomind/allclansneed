class Clan < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :site
  has_many :squads
  
  def members
    SquadUser.all :conditions => {:squad => self.squads}
  end
end
