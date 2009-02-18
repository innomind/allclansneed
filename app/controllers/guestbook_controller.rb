class GuestbookController < ApplicationController
  
  CONTROLLER_ACCESS = PUBLIC

  ACTION_ACCESS_TYPES={
    :destroy => COMPONENT_RIGHT_OWNER,
    :add_comment => COMPONENT_RIGHT_OWNER
  }
  
  add_breadcrumb 'Gästebuch'
  
  def index
    @guestbook = Guestbook.new
    @guestbooks = Guestbook.page_for_site
  end
  
  def create
    @guestbook = Guestbook.new(params[:guestbook])
    @guestbook.site_id = $site_id
    if @guestbook.save
      return if request.xhr?
      render :partial => 'guestbook', :object => @guestbook
    end
  end
  
  def destroy
    @guestbook = Guestbook.find_for_site(params[:id])
    @guestbook.destroy
    return if request.xhr?
    render :nothing, :status => 200
  end
  
  def add_comment
    @guestbook = Guestbook.find_for_site(params[:id])
    @guestbook.update_attribute(:comment, params[:guestbook][:comment])
    @guestbook.update_attribute(:comment_author_id, current_user_id)
    redirect_to :action => "index"
    #return if request.xhr?
  end
end
