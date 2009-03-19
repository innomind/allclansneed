class ClanJoinInquiry < ActiveRecord::Base
  belongs_to :user
  belongs_to :clan
  validates_presence_of :inquiry_text
  #validates_presence_of :clan_name
  
  def clan_name
  end
end