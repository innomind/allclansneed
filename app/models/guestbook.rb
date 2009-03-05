class Guestbook < ActiveRecord::Base
  acts_as_site
  validates_presence_of :name
  validates_presence_of :entry
  #validates_presence_of :comment
  
  belongs_to :site
  belongs_to :user, :foreign_key => "comment_author_id"
  
end
