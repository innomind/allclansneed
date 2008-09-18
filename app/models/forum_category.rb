class ForumCategory < ActiveRecord::Base
  acts_as_tree :order => "position"
  has_many :forum_threads
end
