class ForumThread < ActiveRecord::Base
  belongs_to :account
  has_many :forum_messages
end
