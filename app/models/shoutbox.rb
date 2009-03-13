class Shoutbox < ActiveRecord::Base
  acts_as_site

  validates_presence_of :content
  validates_presence_of :user_id
end
