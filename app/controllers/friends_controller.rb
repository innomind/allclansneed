class FriendsController < ApplicationController
  
  def index
    @friends = current_user.friends
  end
  
  def show
    @friend_user = User.find params[:id]
    @friends = @friend_user.friends
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
      flash[:notice] = "Freundschaft beendet"
    end
    redirect_to start_profiles_path
  end
  
  def become
    @want_friend_with = User.find_by_id(params[:id])
    if current_user == @want_friend_with
      flash[:notice] = "Du kannst nicht mit dir selber Freundschaft schließen" 
    elsif current_user.is_friends_with? @want_friend_with
      flash[:notice] = "Ihr seid bereits Freunde"
    elsif current_user.is_pending_friends_with? @want_friend_with
      flash[:notice] = "Freundschaftsanfrage wurde schon erstellt. Du musst noch die Bestätigung abwarten"
    else
      Postoffice.deliver_become_friend(current_user, @want_friend_with)
      flash[:notice] = "Freundschaftsanfrage erstellt"
      current_user.request_friendship_with @want_friend_with
    end
    redirect_to profile_path(@want_friend_with)
  end
end