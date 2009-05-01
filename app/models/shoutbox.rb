class Shoutbox < ActiveRecord::Base
  acts_as_site

  belongs_to :site
  belongs_to :user
  validates_presence_of :content
  validates_presence_of :user_id
end
