class TicketMessageController < ApplicationController
  
  def new
    @ticket_message = TicketMessage.new
  end
  
  def create
    @conditions = {:author_id => current_user} unless current_user.is_supporter?
    @ticket = Ticket.find(params[:ticket_message][:ticket_id], :conditions => @conditions)
    @ticket_message = @ticket.ticket_messages.new(params[:ticket_message])
    @ticket_message.user = current_user
    
    if @ticket_message.save
      supporter = User.find(:all, :conditions => ["support_status >= 1"])
      if supporter.include?(@ticket_message.user) 
        Postoffice.deliver_new_ticket_message_user(@ticket_message, @ticket_message.ticket.author.email)
      else
        Postoffice.deliver_new_ticket_message_support(@ticket_message, supporter.collect{|u| u.email})  
      end
      redirect_to ticket_path(@ticket)
    else
      redirect_to :controller => "Tickets", :action => "show", :id => @ticket.id
    end
  end
end
