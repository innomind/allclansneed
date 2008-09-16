class Admin::GuestbookController < ApplicationController
  def list
    @guestbook = Guestbook.find(:all)
  end
  
  def new
    @guestbook = Guestbook.new(params[:category])
    if @guestbook.save
      return if request.xhr?  
      render :partial => 'guestbook', :object => @guestbook
    end
  end
 
end
