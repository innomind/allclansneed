class ForumThread < ActiveRecord::Base
  acts_as_site
  belongs_to :user
  belongs_to :forum, :counter_cache => true
  belongs_to :site
  has_many :forum_messages, :dependent => :destroy
  
  validates_presence_of :title
  
  def forum_message=(forum_message)
    forum_messages.build(forum_message)
  end
  
  def self.latest_threads
    find :all, :limit => 5
  end
end
