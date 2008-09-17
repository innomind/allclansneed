class Account < ActiveRecord::Base
  
  has_many :guestbooks
  
  #attr_accessor :password
  #attr_accessible :password, :nick, :email
  validates_presence_of :nick
  validates_presence_of :password
  validates_presence_of :email
  validates_presence_of :site_id
  
  #validates_confirmation_of :email
  validates_uniqueness_of :nick
  validates_uniqueness_of :email
  
  belongs_to :site
  before_save :encrypt_password
  
  
  def encrypt_password
    self[:password] = encrypt self[:password]
  end
  
  def encrypt str
    (Digest::SHA256.new << str).hexdigest!
  end
  
  def check_pw pw
    (encrypt pw) == (self[:password])
  end
end
