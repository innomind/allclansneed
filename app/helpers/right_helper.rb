module RightHelper

  #ok, there is an evil eval, but how to remove it?
  #target is the known :contr =>... :action pair
  #action can't be ommited
  
  def access_link name, target, html_options = nil
    action = target[:action]
    controller = target[:controller]
    unless controller.nil?
      #oh, poor controller, he has now to suffer a bit (violent code) ;)
      controller = controller.split('_').collect{|part| part.capitalize}.join
      controller = (eval "#{controller.to_s}Controller")
    else
      controller = @controller.class
    end
    if controller.user_has_right_for? action
      link_to name, {:controller => controller, :action => action}, html_options
    end
  end
end
