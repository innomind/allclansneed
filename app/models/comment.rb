class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :news
  belongs_to :site
  belongs_to :guestbook
  belongs_to :profile
  belongs_to :gallery_pic
  belongs_to :clanwar
end
