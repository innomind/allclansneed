class Ticket < ActiveRecord::Base
  belongs_to :admin, :class_name  => "User", :foreign_key  => "admin_id"
  belongs_to :author, :class_name => "User", :foreign_key => "author_id"
  
  has_many :ticket_messages, :dependent => :destroy
  
  validates_presence_of :author_id
  validates_presence_of :subject
  
  def ticket_message=(ticket_message)
    ticket_messages.build(ticket_message)
  end
end
