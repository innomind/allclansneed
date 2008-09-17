class GuestbookController < ApplicationController
  def list
    #@guestbook = Guestbook.find(:all, :order => "created_at DESC")
    @guestbook = show()
    #@guestbook = test(:all)
  end
  
  def new
    @guestbook = Guestbook.new(params[:guestbooks])
    @guestbook.site_id = @site_id
    if @guestbook.save
      return if request.xhr?
      render :partial => 'guestbook', :object => @guestbook
    end
  end
  
  def add_comment
    @guestbook = Guestbook.find(params[:id])
    @guestbook.update_attribute(:comment, params[:guestbooks][:comment])
    @guestbook.update_attribute(:comment_author_id, session['user_id'])
    redirect_to :action => "list"
    #return if request.xhr?
  end
end
