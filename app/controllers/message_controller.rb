class MessageController < ApplicationController
  def index
    @messages = Message.find(:all, :conditions => { :receiver_id => current_account_id })
  end
  
  def new
    
  end
  
  def show
    @message = Message.find(params[:id])
    @message.read = TRUE;
    @message.save
  end
  
  def answer
    @message = Message.find(params[:id])
  end
end