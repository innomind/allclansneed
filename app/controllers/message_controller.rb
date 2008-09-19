class MessageController < ApplicationController
  def index
    @messages = Message.find(:all, :conditions => { :receiver_id => current_account_id })
  end
  
  def new
    @possible_receiver = Account.find_for_site(:all)
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
    @message.sender_id = current_account_id
    @message.read = FALSE
    @message.answered = FALSE
    @message.save
    
    redirect_to :action => "index"
  end
end