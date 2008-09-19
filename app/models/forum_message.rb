class ForumMessage < ActiveRecord::Base
  belongs_to :forum_thread
  belongs_to :account
  
  validates_presence_of :message, :message => "must be given"
end
