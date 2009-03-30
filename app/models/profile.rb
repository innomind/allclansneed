class Profile < ActiveRecord::Base
  #acts_as_delegatable
  
  belongs_to :user
  has_many :comments, :as => :commentable, :dependent => :destroy
  
  has_attached_file :profile_pic,
    :styles => {
      :thumb => "100x100#" }#,
    #:path => "/mnt/www1/:attachment/:id/:style/:basename.:extension"
end