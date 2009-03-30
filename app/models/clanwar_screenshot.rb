class ClanwarScreenshot < ActiveRecord::Base
  belongs_to :clanwar
  belongs_to :user
  
  has_attached_file :screenshot,
    :styles => {
      :thumb => "100x100>",
      :large => "800x600>" },
    :path => "/mnt/www1/:attachment/:id/:style/:basename.:extension"  
  validates_attachment_presence :screenshot
  
end