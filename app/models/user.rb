class User < ActiveRecord::Base
  validates_presence_of :login
  validates_presence_of :password
  validates_presence_of :email
  #validates_confirmation_of :email
  validates_uniqueness_of :login
  validates_uniqueness_of :email
  
  has_many :accounts
  
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
