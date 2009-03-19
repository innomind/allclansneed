class Clan < ActiveRecord::Base
  #acts_as_site
  belongs_to :site
  has_many :squads
  has_many :clan_join_inquiries
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  
  validates_format_of :uniq, :with => /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\Z/i, :on => :save
  validates_length_of :uniq, :in => 3..14
  validates_uniqueness_of :uniq  
  
  def before_validation
    self.uniq = self.uniq.downcase
  end
  
#  def site= site
#    site.update_attribute("owner", self.owner)
#    site.update_attribute("subdomain", self.uniq)
#  end  
  
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

  def self.current
    Site.current.clan
  end
  
end
