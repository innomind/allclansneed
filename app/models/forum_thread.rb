class ForumThread < ActiveRecord::Base
  acts_as_site
  belongs_to :user
  belongs_to :site
  has_many :forum_messages, :dependent => :destroy

  belongs_to :threadable, :polymorphic => true, :counter_cache => :threads_count
  belongs_to :forum, :class_name => "Forum",
                      :foreign_key => "threadable_id"
  belongs_to :group, :class_name => "Group",
             :foreign_key => "threadable_id"
  
  validates_presence_of :title
  
  def forum_message=(forum_message)
    forum_messages.build(forum_message)
  end
  
  def self.latest_threads
    find :all, :limit => 5
  end
  
  def anchor
    eval("self.#{self.threadable_type.downcase}")
  end
end
