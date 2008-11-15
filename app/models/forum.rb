class Forum < ActiveRecord::Base
  acts_as_delegatable
  acts_as_tree :order => "position"
  has_many :forum_threads
  belongs_to :site
end
