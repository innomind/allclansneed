module ProfileHelper
  def show_user user
    link_to user.login, profile_path(user)
  end
  
  def become_friends_link user
    if @current_user.is_pending_friends_with? user
      "Freundschaft abwarten"
    else
      access_link "Freund werden", become_friend_path(@profile)
    end
  end
end
