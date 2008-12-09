class GuestbookController < ApplicationController
  
  def index
    #@guestbook = Guestbook.find(:all, :order => "created_at DESC")
    @guestbook = Guestbook.show_model(params[:page], $site_id)
    #@guestbook = Guestbook.find_for_site(:all)
    #@guestbook = test(:all)
  end
  
  def new
    @guestbook = Guestbook.new(params[:guestbooks])
    @guestbook.site_id = $site_id
    if @guestbook.save
      return if request.xhr?
      render :partial => 'guestbook', :object => @guestbook
    end
  end
  
  def delete
    @guestbook = Guestbook.find(params[:id])
    @guestbook.destroy
    return if request.xhr?
    render :nothing, :status => 200
  end
  
  def add_comment
    @guestbook = Guestbook.find(params[:id])
    @guestbook.update_attribute(:comment, params[:guestbooks][:comment])
    @guestbook.update_attribute(:comment_author_id, current_user_id)
    redirect_to :action => "list"
    #return if request.xhr?
  end
end
