class MessagesController < ApplicationController
  auto_complete_for :user, :login
  add_breadcrumb 'Nachrichten', "messages_path"
  
  before_filter :get_message, :only => [:show, :answer, :destroy]
  
  def index
    conditions = params[:folder].nil? ? {:receiver_id => current_user.id} : { :sender_id => current_user.id}
    @messages = Message.paginate :all, :page => params[:page], :per_page => 15, :conditions => conditions, :order => "created_at DESC"
  end
  
  def new
    @message = Message.new
    @message.receiver_id = params[:receiver_id]
    @possible_receiver = current_user.friends
    add_breadcrumb 'Neue Nachricht erstellen'
  end
  
  def show
    @message.update_attribute(:read, true) if @message.receiver == current_user
    add_breadcrumb @message.subject
  end
  
  def answer
    @past_messages = Message.find :all, :conditions => ["(sender_id = ? AND receiver_id = ?) OR (sender_id = ? AND receiver_id = ?)", current_user.id, @message.sender_id, @message.sender_id, current_user.id ], 
                                        :limit => 10,
                                        :order => "created_at DESC"
    add_breadcrumb @message.subject + " antworten"
  end
  
  def create
    add_breadcrumb 'Neue Nachricht erstellen'
    unless params[:message][:answered].nil?
      answered_message = Message.find params[:message][:answered]
      answered_message.answered = true
      answered_message.save
    end
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.read = FALSE
    @message.answered = FALSE
    if @message.save
      Postoffice.deliver_new_message(current_user, @message.receiver)
      flash[:notice] = "Nachricht erfolgreich gesendet"
      redirect_to messages_path
    else
      render :action => new
    end
  end
  
  def destroy
    flash[:notice] = "Nachricht gelöscht" if @message.destroy
    redirect_to messages_path
  end
  
  private
  
  def get_message
    @message = Message.find(params[:id], :conditions => ["receiver_id = ? OR sender_id = ?", current_user, current_user])
  end
end