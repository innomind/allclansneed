class SquadUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :squad
  
  def after_create
    site = self.squad.clan.site
    site.users << self.user unless site.nil?
  end
end
