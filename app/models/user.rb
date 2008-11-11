class User < ActiveRecord::Base

  #has_many :accounts
  
  has_many :pinwalls
  has_many :forum_threads
  has_many :forum_messages
  has_many :guestbooks
  has_many :news
  has_many :messages
  has_many :comments
  has_many :gallery_categories
  has_many :gallery_pics
  
  has_one :profile
  
  #before_save :encrypt_password
  

  has_many :squad_users #??? i don't want this line :( sounds strange: a user has squad_users
  has_many :user_rights, :dependent => :destroy # much better ;)
  has_many :squads, :through => :squad_users
  has_many :sites, :through => :user_rights
  
  validates_presence_of :login
  validates_presence_of :password
  validates_presence_of :email
  #validates_confirmation_of :email
  validates_uniqueness_of :login
  validates_uniqueness_of :email
  #validates_presence_of :site
   
  
  
  def nick= nickname
    self[:login] = nickname
  end
  
  def nick
    self[:login]
  end
  
  def password= pw
    self[:password] = encrypt pw
  end
  
  #def encrypt_password
  #  self[:password] = encrypt self[:password]
  #end
  
  def encrypt str
    (Digest::SHA256.new << str).hexdigest!
  end
  
  def check_pw pw
    (encrypt pw) == (self[:password])
  end

end
