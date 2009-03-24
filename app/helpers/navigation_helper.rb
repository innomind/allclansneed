module NavigationHelper
  def create_navigation_box box
    box.navigations.collect{|nav|
      if nav.navigation_template.nil?
        link_to nav.name, page_path(nav.page)
      else nav.navigation_template.controller.nil?
        link_to nav.name, eval(nav.navigation_template.link_path)
      end
    }
  end
end
