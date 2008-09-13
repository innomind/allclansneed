class User < ActiveRecord::Base
  validates_presence_of :login
  validates_presence_of :password
  validates_presence_of :email
  validates_confirmation_of :email
  validates_uniqueness_of :login
  validates_uniqueness_of :email
  has_many :classifieds
end
