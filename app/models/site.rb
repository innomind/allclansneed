class Site < ActiveRecord::Base
  has_many :guestbooks
  has_many :news_categories
  has_many :gallery_categories
  has_many :gallery_pics
  has_many :forums
  has_many :forum_threads
  has_many :forum_messages
  has_many :clanwars
  has_many :events
  has_many :polls
  
  belongs_to :template
  
  has_many :template_boxes
  has_many :template_areas, :through => :template_boxes
  
  has_many :user_rights
  has_many :users, :through => :user_rights
  has_one :clan
  
  #validates_uniqueness_of :title
  
  PORTAL_ID = 1
  PORTAL_NAME = "A * C * N - Portalseite"
  
  def is_portal?
    (id == SITE_PORTAL_ID)
  end
  
  def portal_name
    PORTAL_NAME
  end
end