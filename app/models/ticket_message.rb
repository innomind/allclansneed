class TicketMessage < ActiveRecord::Base
  
  belongs_to :ticket, :class_name => "Ticket", :foreign_key => "ticket_id", :counter_cache => :ticket_messages_count
  belongs_to :user, :class_name => "User", :foreign_key => "user_id"
  
  validates_presence_of :user_id
  validates_presence_of :message
end
