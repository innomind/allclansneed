module RightHelper

  #target is the known :contr =>... :action pair
  #action is mandatory
  
  def access_link name, target, html_options = nil
    check = Hash.new
    check[:action] = target.delete(:check_action) || 
             target[:action] || 
             "index"
    check[:controller] = target.delete(:check_controller) || 
             target[:controller] || 
             urlize_controller(@controller.class)
    
    if accessible? check
      link_to name, target, html_options
    end
  end
  
  #ha, this def is sugar
  def if_accessible target, &block
    block.call if accessible? target
  end
  
  #ok, there is an evil eval, but how to remove it?
  def accessible? target
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