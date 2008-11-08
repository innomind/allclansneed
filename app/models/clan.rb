class Clan < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :site
  has_many :squads
  
  def squad_members
    SquadUser.all :conditions => {:squad => self.squads}
  end
  
  def members
    self.site.users
  end
  
  def non_squad_members
    
  end
end
