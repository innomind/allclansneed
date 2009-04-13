class TemplatesController < ApplicationController
  add_breadcrumb 'Templates', "templates_path"
  
  def index
    @site = current_site
    @templates = Template.all :conditions => {:account_type => "free"}
  end
  
  def choose
    new_template = Template.find_by_id params[:id]
    raise Exceptions::Access if new_template.account_type != "free"
    old_template = current_site.template
    
    new_template.move_boxes(current_site.template_boxes)
    
    current_site.template = new_template
    if current_site.save
      flash[:notice] = "Template geändert"
    end
    redirect_to templates_path
  end
  
end
