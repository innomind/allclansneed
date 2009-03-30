class FriendsController < ApplicationController
  
  def show
    @friend_user = User.find params[:id]
  end

  def accept
    @current_user = current_user
    @become_friend_with  = User.find_by_id(params[:id])
    
    if @current_user != @become_friend_with
      @current_user.accept_friendship_with @become_friend_with
    end
    flash[:notice] = "Freundschaft bestätigt"
    redirect_to profile_path(@become_friend_with)
  end
    
  def destroy
    @current_user = current_user
    @become_friend_with  = User.find_by_id(params[:id])
    
    if @current_user != @become_friend_with
      @current_user.delete_friendship_with @become_friend_with
    end
  end
  
  def become
    @want_friend_with = User.find_by_id(params[:id])
    @current_user = current_user
    
    if @current_user != @want_friend_with
      flash[:notice] = "Freundschaftsanfrage erstellt"
      current_user.request_friendship_with @want_friend_with
    end
    redirect_to profile_path(@want_friend_with)
    #user per mail benachrichtigen
    #muss noch implementiert werden
  end
  
  def index
    @friends = current_user.friends
  end
end