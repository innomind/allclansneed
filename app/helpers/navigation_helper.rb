module NavigationHelper
  def create_navigation_box box
    box.navigations.collect{|nav|
      if nav.navigation_template.controller.nil?
        link_to nav.name, eval(nav.navigation_template.link_path)
      else
        link_to nav.name, :controller => nav.navigation_template.controller, 
                          :action => nav.navigation_template.action
      end
    }
  end
end
