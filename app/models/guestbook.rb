class Guestbook < ActiveRecord::Base
  acts_as_delegatable
  validates_presence_of :name
  validates_presence_of :entry
  #validates_presence_of :comment
  
  belongs_to :site
  belongs_to :user, :foreign_key => "comment_author_id"
  
  def self.show_model(page, site_id)
    paginate_for_site
  end
end
