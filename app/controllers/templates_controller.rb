class TemplatesController < ApplicationController
  add_breadcrumb 'Templates', "templates_path"
  
  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER
  
  def index
    
  end
  
  def choose
    @site = current_site
    @templates = Template.all
  end
  
  def edit
  end
  
  def update
  end
end
