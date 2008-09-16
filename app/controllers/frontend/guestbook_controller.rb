class Frontend::GuestbookController < ApplicationController
  def index
    
  end
  
  def list
    @guestbook = Guestbook.find(:all, :order => "created_at DESC")
  end
  
  def new
    @guestbook = Guestbook.new(params[:guestbooks])
    if @guestbook.save
      return if request.xhr?
      render :partial => 'category', :object => @guestbook
    end
  end
end
