class FriendsController < ApplicationController

  def accept
    @current_user = current_user
    @become_friend_with  = User.find_by_id(params[:id])
    
    if @current_user != @become_friend_with
      @current_user.accept_friendship_with @become_friend_with
    end
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
      current_user.request_friendship_with @want_friend_with
    end
    render :text => "test"
    #user per mail benachrichtigen
    #muss noch implementiert werden
  end
  
  def index
    @friends = current_user.friends
  end
end