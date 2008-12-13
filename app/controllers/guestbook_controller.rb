class GuestbookController < ApplicationController
  
  def index
    @guestbook = Guestbook.paginate_for_site
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
    @guestbook = Guestbook.find_for_site(params[:id])
    @guestbook.destroy
    return if request.xhr?
    render :nothing, :status => 200
  end
  
  def add_comment
    @guestbook = Guestbook.find_for_site(params[:id])
    @guestbook.update_attribute(:comment, params[:guestbooks][:comment])
    @guestbook.update_attribute(:comment_author_id, current_user_id)
    redirect_to :action => "index"
    #return if request.xhr?
  end
end
