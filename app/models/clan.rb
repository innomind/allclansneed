class Clan < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :site
  has_many :squads
  
  
  def squad_members
    ((SquadUser.all :conditions => {:squad_id => self.squads.collect {|s| s.id}}).collect {|su| su.user}).uniq
  end
  
  def site_members
    self.site.users
  end
  
  def members opt = {:through => :squads}
    if opt[:through] == :squads
      squad_members
    else if opt[:through] == :site
        site_members
      else
        nil
      end
    end
  end
  
end
