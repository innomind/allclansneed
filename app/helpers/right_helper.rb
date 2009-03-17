module RightHelper

  #target is the known :contr =>... :action pair
  #action is mandatory
  
  def access_link name, target, html_options = {}
    check = Hash.new
    if target.is_a?(String)
      html_options[:method] ||= :get
      
      check = ActionController::Routing::Routes.recognize_path(target, {:method => html_options[:method].to_sym})
    else
      check[:action] = target.delete(:check_action) || target[:action] || "index"
      check[:controller] = target.delete(:check_controller) || target[:controller] || urlize_controller(@controller.class)
      target = target.delete(:path) if target.has_key? :path
    end
    
    return if @user.nil?
    if @user.can_access? check
      link_to name, target, html_options
    end
  end
  
  def access_link_if condition, name, target, html_options = nil
    access_link(name, target, html_options) if condition
  end
  
  def access_link_unless condition, name, target, html_options = nil
    access_link(name, target, html_options) unless condition
  end
  
  def access_remote_link name, target, html_options = nil
    link_to_remote name, target, html_options
  end
  
  #ha, this def is sugar
  def if_accessible target, &block
    block.call if @user.can_access? target
  end
  
  def urlize_controller contr_name_or_class
    contr_name_or_class.to_s.underscore.gsub(/_controller$/, '')
  end
end
