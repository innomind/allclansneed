class SquadUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :squad
  #belongs_to :role, :class_name => "Category", :foreign_key => "role_id"
  
  def after_create
    site = self.squad.clan.site
    site.users << self.user unless site.nil?
  end
end
