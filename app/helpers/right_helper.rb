module RightHelper

  #ok, there is an evil eval, but how to remove it?
  #target is the known :contr =>... :action pair
  #action is mandatory
  
  def access_link name, target, html_options = nil
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
      controller_name = controller.class.to_s.underscore
    end
    if controller_class.user_has_right_for? action
      link_to name, {:controller => controller_name, :action => action}, html_options
    end
  end
end
