class Forum < ActiveRecord::Base
  acts_as_site
  acts_as_tree :order => "position"
  has_many :forum_threads, :as => :threadable, :dependent => :destroy
  belongs_to :site
  
  validates_presence_of :title
end
