class Session
  
  def set_user user
    @user = user
  end
  
  def set_controller controller
    @controller = controller
  end
  
  def can_access? check
    return true if Rights.lookup_class(check[:controller], check[:action]) == "public"
    return false if @user.nil?
    @user.can_access? check
  end
  
  def can_access_link? target, html_options = {}
    check = Hash.new
    if target.is_a?(String)
      html_options[:method] ||= :get
      
      begin
        check = ActionController::Routing::Routes.recognize_path(target, {:method => html_options[:method].to_sym})
      rescue ActionController::RoutingError
        check = ActionController::Routing::Routes.recognize_path(target.split("?")[0], {:method => html_options[:method].to_sym})
      end
      
    else
      check[:action] = target.delete(:check_action) || target[:action] || "index"
      check[:controller] = target.delete(:check_controller) || target[:controller] || @controller
      target = target.delete(:path) if target.has_key? :path
    end
    
    return true if self.can_access? check
    false
  end
  
  def belongs_to_current_site?
    return false if @user.nil?
    @user.belongs_to_current_site?
  end
  
  def belongs_to_site? site
    return false if @user.nil?
    @user.belongs_to_site? site
  end
  
  def is_guest?
    return false if @user.nil?
    @user.is_guest
  end
  
  def logged_in?
    !@user.nil?
  end
  
  def urlize_controller contr_name_or_class
    contr_name_or_class.to_s.underscore.gsub(/_controller$/, '')
  end
end