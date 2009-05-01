class Moderator < ActiveRecord::Base
  acts_as_site

  belongs_to :forum
  belongs_to :site
  belongs_to :user
end
