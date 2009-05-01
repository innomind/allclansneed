module ProfileHelper
  
  def show_profile_prop name, func = ""
    return "<dt>#{Profile.human_attr_name(name)}</dt><dd>#{eval(func + " @profile." + name)}</dd>" unless eval("@profile." + name).to_s.empty?		
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
      return "du musst angemeldet sein"
    end
  end
  
  def become_friends_link user
    return "" unless @current_session.logged_in?
    if @current_user.is_pending_friends_with? user
      "Freundschaft abwarten"
    elsif !@current_user.is_friends_with?(user) && @current_user != user
      access_link "Freund werden", become_friend_path(@profile)
    end
  end
end
