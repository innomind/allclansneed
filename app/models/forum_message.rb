class ForumMessage < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :forum_thread
  belongs_to :user
  belongs_to :site
  
  validates_presence_of :message, :message => "es muss eine Nachricht angegeben werden"

end
