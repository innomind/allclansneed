class Ticket < ActiveRecord::Base
  
  belongs_to :admin, :class_name  => "User", :foreign_key  => "admin_id"
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  
  belongs_to :status, :class_name => "Category", :foreign_key => "status_id"
  belongs_to :category
  
  belongs_to :site
  
  has_many :ticket_messages, :dependent => :destroy
  
  validates_presence_of :author_id
  validates_presence_of :subject
  
  def ticket_message=(ticket_message)
    ticket_messages.build(ticket_message)
  end
  
  def before_create
    self.status = Category.find :first, :global => true, :conditions => {:controller => "Ticket", :section => "status", :name => "offen"}
  end
end
