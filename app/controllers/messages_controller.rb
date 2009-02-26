class MessagesController < ApplicationController
  auto_complete_for :user, :login
  def index
    @messages = Message.find(:all, :conditions => { :receiver_id => current_user_id })
  end
  
  def new
    @message = Message.new
    @possible_receiver = User.find(:all)
  end
  
  def show
    @message = Message.find(params[:id])
    @message.read = TRUE;
    @message.save
  end
  
  def answer
    @message = Message.find(params[:id])
  end
  
  def create
    @message = Message.new(params[:message])
    @message.sender = current_user
    @message.read = FALSE
    @message.answered = FALSE
    @message.save
    
    redirect_to :action => "index"
  end
end