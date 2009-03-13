class TicketMessageController < ApplicationController
  
  def new
    @ticket_message = TicketMessage.new
  end
  
  def create
    @ticket = Ticket.find(params[:ticket_message][:ticket_id])
    @ticket_message = @ticket.ticket_messages.new(params[:ticket_message])
    @ticket_message.user = current_user
    
    if @ticket_message.save
      redirect_to ticket_path(@ticket)
    else
      redirect_to :controller => "Tickets", :action => "show", :id => @ticket.id
    end
  end
end
