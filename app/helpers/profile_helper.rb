module ProfileHelper
  def show_user user
    link_to user.login, profile_path(user)
  end
  
  def show_connection
    if @profile.user == @current_user
      return "Dies bist du selber"
    end
    if @connection == "direct"
      return username(@current_user) + "->" + username(@profile.user)
    elsif @connection == "indirect"
      return username(@current_user) + "->" + username(@friend_of_both) + "->" + username(@profile.user)
    elsif @connection == "none"
      return "Keine Verbindung"
    elsif !@current_session.logged_in?
      return "Du musst eingeloggt sein, um die Verbindung zu diesem User sehen zu können und um ihn als Freund hinzuzufügen."
    end
  end
  
  def become_friends_link user
    if @current_user.is_pending_friends_with? user
      "" #"Freundschaft abwarten"
    else
      access_link "Freund werden", become_friend_path(@profile)
    end
  end
end
