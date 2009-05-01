class TicketsController < ApplicationController
  
  add_breadcrumb 'Tickets', 'tickets_path'
  
  before_filter :init_condition
  before_filter :init_ticket, :only => [:show, :edit, :update, :destroy]
  
  def index
    #debugger
    @tickets = Ticket.paginate :page => params[:page], :per_page => 15, :conditions => @conditions
  end

  def show
    @ticket_category = Category.find(:first, :global => true, :conditions => {:id => @ticket.category_id})
    @ticket_status = Category.find(:first, :global => true, :conditions => {:id => @ticket.status_id})
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
  end
  
  def create
    @ticket = Ticket.new(params[:ticket])
    @ticket.ticket_messages[0].user = current_user
    @ticket.author = current_user
    if @ticket.save
      Postoffice.deliver_new_ticket(User.find(:all, :conditions => ["support_status >= 1"]), @ticket)
      flash[:notice] = 'Ticket erfolgreich erstellt.'
      redirect_to(@ticket)
    else
      render :action => "new"
    end
  end

  def update
    if @ticket.update_attributes(params[:ticket])
      flash[:notice] = 'Ticket erfolgreich geändert.'
      redirect_to(@ticket)
    else
        render :action => "edit"
    end
  end

  def destroy
    flash[:notice] = "Ticket gelöscht" if @ticket.destroy
    redirect_to(tickets_url)
  end
  
  private
  
  def init_condition
    @conditions = {:author_id => current_user} unless current_user.is_supporter?
  end
  
  def init_ticket
    @ticket = Ticket.find(params[:id], :conditions => @conditions)
  end
  
end
