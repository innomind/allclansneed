class ForumMessage < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :forum_thread
  belongs_to :user
  belongs_to :site
  
  validates_presence_of :message, :message => "must be given"

  def self.search(search, page)
    paginate :per_page => 5, :page => page,
             :conditions => ['forum_thread_id = ?', "#{search}"],
             :order => 'created_at ASC'
  end

end
