class GuestbookController < ApplicationController
  
  add_breadcrumb 'Gästebuch'
  
  def index
    @guestbook = Guestbook.new
    @guestbooks = Guestbook.paginate
  end
  
  def create
    @guestbook = Guestbook.new(params[:guestbook])
    if @guestbook.save
      flash[:notice] = "Gästebucheintrag erstellt" 
    else
      flash[:error] = "Fehler beim erstellen"
    end    
    redirect_to guestbooks_path
  end
  
  def destroy
    @guestbook = Guestbook.find(params[:id])
    @guestbook.destroy
    redirect_to guestbook_path
  end
  
  def add_comment
    @guestbook = Guestbook.find(params[:id])
    @guestbook.update_attribute(:comment, params[:guestbook][:comment])
    @guestbook.update_attribute(:comment_author_id, current_user.id)
    flash[:notice] = "Kommentar gespeichert"
    redirect_to guestbooks_path
    #return if request.xhr?
  end
end
