class Guestbook < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :entry
end
