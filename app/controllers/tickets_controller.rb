class TicketsController < ApplicationController
  
  add_breadcrumb 'Tickets', 'tickets_path'
  
  CONTROLLER_ACCESS = SITE_MEMBER
  
  ACTION_ACCESS_TYPES={
    :destroy => COMPONENT_RIGHT_OWNER
  }
  
  before_filter :init_ticket, :only => [:show]
  
  def index
    @tickets = Ticket.all
  end

  def show
    @ticket = Ticket.find(params[:id])
    @category = Category.find(:first, :global => true, :conditions => {:id => @ticket.category_id})
    @status = Category.find(:first, :global => true, :conditions => {:id => @ticket.status_id})
    @messages = @ticket.ticket_messages
    @answer = TicketMessage.new
    
    add_breadcrumb @ticket.subject
  end
  
  def new
    add_breadcrumb 'neues Ticket erstellen'
    @ticket = Ticket.new
    @ticket.ticket_messages.build
  end
  
  def edit
    add_breadcrumb 'Ticket bearbeiten'
    @ticket = Ticket.find(params[:id])
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.ticket_messages[0].user = current_user
    @ticket.author = current_user
    if @ticket.save
      flash[:notice] = 'Ticket was successfully created.'
      redirect_to(@ticket)
    else
      render :action => "new"
    end
  end

  def update
    @ticket = Ticket.find(params[:id])

    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = 'Ticket was successfully updated.'
      redirect_to(@ticket)
    else
        render :action => "edit"
    end
  end

  def destroy
    @ticket = Ticket.find(params[:id])
    flash[:notice] = "Ticket gelöscht" if @ticket.destroy
    redirect_to(tickets_url)
  end
  
  private
  
  def init_ticket
  end
  
  def init_scope
     #if is_portal?
  end
end
