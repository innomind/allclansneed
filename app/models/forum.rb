class Forum < ActiveRecord::Base
  acts_as_site
  acts_as_tree :order => "position"
  has_many :forum_threads, :as => :threadable, :dependent => :destroy
  has_many :moderators
  belongs_to :site
  
  validates_presence_of :title
  
  def after_update
    return if self.forum_threads.empty?
    f = Forum.find(id, :include => {:forum_threads => :forum_messages})
    if f.intern != intern
      f.forum_threads.each do |t| 
        t.intern = intern
        t.save
        t.forum_messages.each do |m|
          m.intern = intern
          m.save
        end
      end
    end
  end
end
