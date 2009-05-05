module UsersHelper
  def show_signature(user)
    "<div class=\"signature\">#{simple_format user.signature}</div>"
  end
  
  def show_status(user)
    if user.is_online?
      image_tag("status_online.png", :class => "icon") + "Online"
    else
      image_tag("status_offline.png", :class => "icon") + "Offline"
    end
  end
end
