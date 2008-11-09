class Guestbook < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :entry
  #validates_presence_of :comment
  
  belongs_to :site
  belongs_to :user, :foreign_key => "comment_author_id"
  
  def self.show_model(page, site_id)
    paginate :per_page => 2, :page => page, :order => 'created_at DESC',
             :conditions => { :site_id => site_id }
  end
end
