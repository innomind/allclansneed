class GuestbookController < ApplicationController
  
  CONTROLLER_ACCESS = PUBLIC

  ACTION_ACCESS_TYPES={
    :destroy => COMPONENT_RIGHT_OWNER,
    :add_comment => COMPONENT_RIGHT_OWNER
  }
  
  add_breadcrumb 'Gästebuch'
  
  def index
    @guestbook = Guestbook.new
    @guestbooks = Guestbook.paginate
  end
  
  def create
    @guestbook = Guestbook.new(params[:guestbook])
    if @guestbook.save
      return if request.xhr?
      render :partial => 'guestbook', :object => @guestbook
    end
  end
  
  def destroy
    @guestbook = Guestbook.find(params[:id])
    @guestbook.destroy
    return if request.xhr?
    render :nothing, :status => 200
  end
  
  def add_comment
    @guestbook = Guestbook.find(params[:id])
    @guestbook.update_attribute(:comment, params[:guestbook][:comment])
    @guestbook.update_attribute(:comment_author_id, current_user_id)
    flash[:notice] = "Kommentar gespeichert"
    redirect_to guestbook_path
    #return if request.xhr?
  end
end
