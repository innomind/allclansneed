class Forum < ActiveRecord::Base
  acts_as_delegatable
  acts_as_tree :order => "position"
  has_many :forum_threads, :dependent => :destroy
  belongs_to :site
  
  validates_presence_of :title
end
