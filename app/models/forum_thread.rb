class ForumThread < ActiveRecord::Base
  belongs_to :account
  has_many :forum_messages
  
  validates_presence_of :title
  
  def forum_message=(forum_message)
    forum_messages.build(forum_message)
  end
end
