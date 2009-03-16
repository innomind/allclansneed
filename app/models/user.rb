class User < ActiveRecord::Base
  
  has_many_friends

  has_many :forum_threads
  has_many :forum_messages
  has_many :guestbooks
  has_many :news
  has_many :messages
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
    
  has_many :user_rights, :dependent => :destroy
  has_many :sites, :through => :user_rights
  has_many :components, :through => :user_rights
  
  validates_presence_of :login
  validates_presence_of :password
  validates_presence_of :email
  #validates_confirmation_of :email
  validates_uniqueness_of :login
  validates_uniqueness_of :email
  #validates_presence_of :site
   
  def password= pw
    self[:password] = encrypt pw
  end
  
  def encrypt str
    (Digest::SHA256.new << str).hexdigest!
  end
  
  #access types
  PUBLIC = 0
  ACN_MEMBER = 1
  SITE_MEMBER_ = 2
  SITE_MEMBER = ACN_MEMBER | SITE_MEMBER_
  COMPONENT_RIGHT_OWNER = 4
  
  #don't change the position, it must be located AFTER def password=...
  #migrate 20081022180305 & 20081119122051 down&up, to insert new users
  
  def self.acn_dev_users
    return [
    User.new(  :login  => "philipp",
      :password => "test",
      :email => "pw@allclansneed.de"
    ),
    User.new(  :login  => "ben",
      :password  => "test",
      :email => "ben@test.de"
    ),
    User.new(  :login  => "valentin",
      :password => "test",
      :email => "valentin.schulte@gmx.de"
    ),
    User.new(  :login => "superadmin",
      :password => "supertest",
      :email => "superadmin@dev.innomind.info"
    )
  ] #if table_exists?
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
  
  def encrypt str
    (Digest::SHA256.new << str).hexdigest!
  end
  
  def check_pw pw
    (encrypt pw) == (self[:password])
  end

  
  def clans_with_site
    (sites.collect {|s| s.clan}).compact
  end
  
  #alle squads, in denen der user in DIESEM clan ist
  def squads_in_clan c
    c.squads.select{|s| s.users.include? self}
  end
  
  def self.all_dev_users
    find :all, :conditions => {:login => User.acn_dev_users.collect {|u| u.login}}
  end


  ### Rechte
  
  def rights
    self.user_rights
  end
  
  def right_for_site site_id
    UserRight.find :all, :conditions => {:user_id => self.id, :site_id => site_id}
  end
  
  def local_rights
    right_for_site $site_id
  end
  
  def components_for_site site_id
    (right_for_site site_id).components
  end
  
  def has_component? c
    !!(user_rights.find :first, :conditions => {:site_id => $site_id, :component_id => c})
  end
  
  def components
    @component_list ||= Component.find :all, :joins => :user_rights, :conditions => ["user_rights.site_id = ?",$site_id]
  end
  
  def has_right_for? controller
    !components.select{|c| c.controller == controller}.empty?
  end
  
  #def components
  #  #self.components
  #end
  
  #def components
  #  local_rights.each do |right|
  #    right.component
  #  end
  #  #local
  #end
  
  
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
end
