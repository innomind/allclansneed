class ShoutboxController < ApplicationController
  
  def create
    @shout = Shoutbox.new(params[:content])
    if @shout.save
      return if request.xhr?
    end
  end

  def add_shout
    @guestbook = Guestbook.find(params[:id])
    @guestbook.update_attribute(:comment, params[:guestbook][:comment])
    @guestbook.update_attribute(:comment_author_id, current_user_id)
    flash[:notice] = "Kommentar gespeichert"
    redirect_to guestbook_path
    #return if request.xhr?
  end

end
