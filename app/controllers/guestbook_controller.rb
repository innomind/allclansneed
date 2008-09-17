class GuestbookController < ApplicationController
  def list
    @guestbook = Guestbook.find(:all, :order => "created_at DESC")
  end
  
  def new
    @guestbook = Guestbook.new(params[:guestbooks])
    if @guestbook.save
      return if request.xhr?
      render :partial => 'guestbook', :object => @guestbook
    end
  end
end
