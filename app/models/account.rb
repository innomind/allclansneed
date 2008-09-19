class Account < ActiveRecord::Base

  has_many :forum_threads
  has_many :forum_messages
  has_many :guestbooks
  has_many :news
  belongs_to :user
  
  ALL_RIGHTS =  #News
  
                'News/create '+
                'News/edit '+
                'News/new '+
                'News/update '+
                'News/delete '+
                
                #Guestbook
                'Guestbook/add_comment '+
                'Guestbook/new '+
                'Guestbook/delete '+
                
                #Forum
                'Forum/delete '+
                'Forum/create_thread '+
                'Forum/new_thread '+
                'Froum/create_category'+
                
                #
                ''
  
  #attr_accessor :password
  #attr_accessible :password, :nick, :email
  #validates_presence_of :nick
  #validates_presence_of :password
  #validates_presence_of :email
  validates_presence_of :site_id
  
  #validates_confirmation_of :email
  #validates_uniqueness_of :nick
  #validates_uniqueness_of :email
  
  belongs_to :site
end
