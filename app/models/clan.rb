class Clan < ActiveRecord::Base
  #acts_as_site
  belongs_to :site
  has_many :squads
  has_many :squad_users, :through => :squads
  has_many :clan_join_inquiries
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many :comments, :as => :commentable
  
  validates_format_of :uniq, :with => /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\Z/i, :on => :save
  validates_length_of :uniq, :in => 3..14
  validates_uniqueness_of :uniq  
  validates_presence_of :owner_id
  
  has_attached_file :clan_pic,
    :styles => {
      :thumb => "100x100#" }
  
  def before_validation
    self.uniq = self.uniq.downcase
  end
  
  def after_create
    squad = self.squads.create(:name => "Main Squad")
    add_user self.owner, squad
  end
  
  def squad_members
    ((SquadUser.all :conditions => {:squad_id => self.squads.collect {|s| s.id}}).collect {|su| su.user}).uniq
  end
  
  def site_members
    self.site.users
  end
  
  def site= site
    squad_members.each{|sm| sm.sites << site}
    self.update_attribute("site_id", site.id)
  end
  
  def add_user user, squad
    squad.users << user
    user.sites << self.site unless self.site.nil?
    self.update_attribute("members_count", self.members_count+1)
  end
  
  def remove_user user
    self.squads.each{|squad| SquadUser.destroy_all(:user_id => user.id, :squad_id => squad.id)}
    UserRight.destroy_all(:user_id => user.id, :site_id => self.site.id)
    self.update_attribute("members_count", self.members_count-1)
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
