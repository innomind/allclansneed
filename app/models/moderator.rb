class Moderator < ActiveRecord::Base
  belongs_to :forum
  belongs_to :site
  belongs_to :user
end
