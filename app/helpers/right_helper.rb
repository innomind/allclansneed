module RightHelper

  #target is the known :contr =>... :action pair
  #action is mandatory
  
  def access_link name, target, html_options = nil
    check = Hash.new
    if target.is_a?(String)
      check = ActionController::Routing::Routes.recognize_path(target, {:method => :get})
    else
      check[:action] = target.delete(:check_action) || 
             target[:action] || 
             "index"
      check[:controller] = target.delete(:check_controller) || 
             target[:controller] || 
             urlize_controller(@controller.class)
      target = target.delete(:path) if target.has_key? :path
    end
    if accessible? check
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
    block.call if accessible? target
  end
  
  #ok, there is an evil eval, but how to remove it?
  def accessible? target
    return true
    action = target[:action]
    controller_name = target[:controller]
    unless controller_name.nil?
      #oh, poor controller, he has now to suffer a bit (violent code ;) )
      controller_class_name = controller_name.to_s.classify# hooo, "deviolated"... split('_').collect{|part| part.capitalize}.join
      controller_class = (eval "#{controller_class_name}Controller")
      #2nd evil hack
      controller_class.static_session = @controller.class.static_session
      #you could easily change this to access foreign sites
      controller_class.current_site = @controller.class.current_site
    else
      controller_class = @controller.class
    end
    controller_class.user_has_right_for? action
  end
  
  def urlize_controller contr_name_or_class
    contr_name_or_class.to_s.underscore.gsub(/_controller$/, '')
  end
end
