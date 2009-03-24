class MessagesController < ApplicationController
  auto_complete_for :user, :login
  add_breadcrumb 'Nachrichten', "messages_path"
  
  def index
    @messages = Message.paginate :all, :page => params[:page], :per_page => 15, :conditions => { :receiver_id => current_user.id }, :order => "created_at DESC"
  end
  
  def new
    @message = Message.new
    @possible_receiver = current_user.friends
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
      flash[:notice] = "Nachricht erfolgreich gesendet"
      redirect_to messages_path
    else
      render :action => new
    end
  end
end