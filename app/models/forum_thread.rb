class ForumThread < ActiveRecord::Base
  belongs_to :account
  belongs_to :forum_cotegory#, :counter_cache => true
  has_many :forum_messages
  
  validates_presence_of :title
  
  def forum_message=(forum_message)
    forum_messages.build(forum_message)
  end
end
