class User < ActiveRecord::Base
  
  has_many_friends

  has_many :forum_threads
  has_many :forum_messages
  has_many :guestbooks
  has_many :news
  has_many :incoming_messages, :class_name => "Message", :foreign_key => :receiver_id
  has_many :outgoing_messages, :class_name => "Message", :foreign_key => :sender_id
  has_many :comments
  has_many :gallery_categories
  has_many :gallery_pics
  has_many :clanwars
  has_many :polls
  has_many :poll_results
  has_many :classifieds
  
  has_one :profile
  
  has_many :groupmemberships
  has_many :groups, :through => :groupmemberships
  has_many :groupfounderships, :class_name => "Group", :foreign_key => :founder_id
  
  has_many :squad_users
  has_many :squads, :through => :squad_users
  
  has_many :clan_ownerships, :class_name => "Clan", :foreign_key => :owner_id
  has_many :site_ownerships, :class_name => "Site", :foreign_key => :owner_id
  
  has_many :clan_join_inquiries
  
  has_many :user_rights, :dependent => :destroy
  has_many :sites, :through => :user_rights
  has_many :components, :through => :user_rights

  validates_presence_of :password
  validates_presence_of :email
  #validates_confirmation_of :email
  validates_uniqueness_of :login
  validates_format_of :login, :with => /\A[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\Z/i, :on => :save
  validates_length_of :login, :in => 3..14
  validates_uniqueness_of :email
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :save
   
  def before_validation
    self.email = self.email.downcase
    self.login = self.login.downcase
  end 
   
  def after_create
    self.profile = Profile.create
  end
  
  def encrypt str
    (Digest::SHA256.new << str).hexdigest!
  end
  
  def nick= nickname
    self[:login] = nickname
  end
  
  def nick
    self[:login]
  end
  
  def password= pw
    self[:password] = encrypt pw
  end
  
  def check_pw pw
    (encrypt pw) == (self[:password])
  end

  def clans
    squads.all(:include => :clan).collect{|s| s.clan}.compact.uniq
  end

  def clans_with_site
    (sites.collect {|s| s.clan}).compact
  end
  
  #alle squads, in denen der user in DIESEM clan ist
  def squads_in_clan c
    c.squads.select{|s| s.users.include? self}
  end

  ### Rechte
  
  def owns_clan? clan
    clan_ownerships.include? clan
  end
  
  def owns_site? site
    site_ownerships.include? site
  end
  
  def owns_current_site?
    owns_site? @current_site
  end
  
  def owns_current_clan?
    owns_clan? @current_site.clan
  end
  
  #deprecated
  def has_component? c
    !!(user_rights.find :first, :conditions => {:site_id => $site_id, :component_id => c})
  end
  
  # TODO cache
  def components
    @component_list ||= Component.find :all, :joins => :user_rights, :conditions => ["user_rights.site_id = ? AND user_id = ?",$site_id, self.id]
  end
  
  def has_right_for? controller
    return true if self.owns_current_site?
    !components.select{|c| c.controller == controller}.empty?
  end
  
  def can_access? check
    check[:action] ||= "index"
    right = Rights.lookup_class(check[:controller], check[:action])
    return true if owns_current_site?
    
    case right
    when "public"
      true
    when "member"
      logged_in?
    when "site"
      belongs_to_current_site?
    when "right"
      has_right_for? check[:controller]
    else 
      true
    end
  end
  
  ## Session
  
  def logged_in?
    @logged_in
  end
  
  def logged_in= status
    @logged_in = status
  end
  
  def belongs_to_current_site?
    belongs_to_site? @current_site
  end
  
  def belongs_to_site? site
    sites.include? site
  end
  
  def belongs_to_clan? clan
    clans.include? clan
  end
  
  def is_guest?
    !belongs_to_site?
  end
  
  def current_site= site
    @current_site = site
  end
  
  ### Gruppen
  
  def membership group
    mship = Groupmembership.find(:first, :conditions => {:group_id  => group.id, :user_id => self[:id]})
    if mship.nil?
      mship = Groupmembership.new
      mship.status = "false"
    end
      mship
  end
  
  def status_for_group group
    (membership group).status
  end
  
  ### Tickets
  
  def is_supporter?
    support_status?
  end

  def self.get_supporter_for_select
    find(:all, :conditions => {:support_status => 1}).collect{|u| [u.login, u.id]}
  end
  

  ### Nachrichten
  
  def new_messages
    self.incoming_messages.count :conditions => {:read => false}
  end
  
  ### remove Functions
  
  def leave_clan leave_clan
    self.squads -= leave_clan.squads
    UserRight.destroy_all :site_id => leave_clan.site.id
  end
end
