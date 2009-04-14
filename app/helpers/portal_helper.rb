module PortalHelper
  def section_visible? section
    
    @section_links ||= {
      :netzwerk => {:controller => [:news, :tickets, :friends, :profile, :messages, :clans, :groups, :forum, :forum_thread, :forum_message, :users], :pages => []},
      :clanpage => {:controller => [:site], :pages => [:Support, :Funktionen]},
      :game_server => {:controller => [], :pages => [:Aktionen, :Preise, :Hardware, :Testserver]}
    }
    @already_run ||= @section_links.each{|s|
      if params[:controller] == "pages"  
        @section_visible = s[0] if s[1][:pages].include?((params["id"] || " ").to_sym)
      else
        @section_visible = s[0] if s[1][:controller].include?(params["controller"].to_sym)
      end
    }
    return false if section.to_sym != @section_visible
    true
  end
  
  def section_visible section
    section_visible?(section) ? "" : "display:none"
  end
  
  def section_link_class section
    section_visible?(section) ? "chosen" : ""
  end
  
  def section_link section, internal = nil
    internal ||= section.downcase
    link_to_function(section, :class => section_link_class(internal)) do |page|
    	 page.select('div.navigation').each do |value|
    	     value.hide
    	  end
    	 page["nav_#{internal}"].show
    end
  end
end