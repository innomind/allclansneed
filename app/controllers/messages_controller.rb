class MessagesController < ApplicationController
  auto_complete_for :user, :login
  add_breadcrumb 'Nachrichten', "messages_path"
  
  def index
    @messages = Message.find(:all, :conditions => { :receiver_id => current_user.id }, :order => "created_at DESC")
  end
  
  def new
    @message = Message.new
    @possible_receiver = User.find(:all)
    add_breadcrumb 'Neue Nachricht erstellen'
  end
  
  def show
    @message = Message.find(params[:id])
    @message.read = TRUE;
    @message.save
    add_breadcrumb @message.subject
  end
  
  def answer
    @message = Message.find(params[:id])
    add_breadcrumb @message.subject + " antworten"
  end
  
  def create
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.read = FALSE
    @message.answered = FALSE
    if @message.save
      flash[:notice] = "Nachricht erfolgreich gesendet"
      redirect_to messages_path
    else
      render :action => new
    end
  end
end