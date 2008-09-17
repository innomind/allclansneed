class NewsComment < ActiveRecord::Base
  belongs_to :news, :foreign_key  => "news_id"
  belongs_to :account, :foreign_key => "author_id"
end
