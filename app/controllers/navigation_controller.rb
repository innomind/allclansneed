class NavigationController < ApplicationController
  def edit_box
    add_breadcrumb 'Boxen bearbeiten', "boxes_path"
    add_breadcrumb 'Navigation bearbeiten'
    @navigations = Navigation.find :all, :conditions => { :template_box_id => params[:template_box_id]},
                                         :include => [:navigation_template], :order => :position
  end
  
  def new
    @box = TemplateBox.find params[:template_box_id]
    @navigation_templates = NavigationTemplate.unused_types.collect{|b| [b.name, b.id]}
    @navigation = @box.navigations.new(:template_box_id => @box.id)
    render :layout => false
  end
  
  def create
    @navigation = Navigation.new params[:navigation]
    if @navigation.save
      flash[:notice] = "Navigationspunkt erfolgreich erstellt"
    else
      flash[:error] = "Fehler beim speichern der Navigation"
    end
    redirect_to edit_box_navigations_path(:template_box_id => params[:navigation][:template_box_id])
  end
  
  def edit
    @navigation = Navigation.find params[:id]
    render :layout => false
  end
  
  def update
    @navigation = Navigation.find params[:id]
    @navigation.update_attributes(params[:navigation])
    if @navigation.save
      flash[:notice] = "Navigation erfolgreich geändert"
    else
      flash[:error] = "Fehler beim ändern der Navigation"
    end
    redirect_to edit_box_navigations_path(:template_box_id => @navigation.template_box_id)
  end
  
  def update_positions
   params["navigations"].each_with_index do |id, position|
     Navigation.update(id, :position => position)
   end
   render :nothing => true
  end
  
  def move
    @navigation = Navigation.find_by_id params[:id]
    type = TemplateBoxType.find_by_name "Navigation"
    @possible_boxes = type.template_boxes.find( :all, :conditions => ["id <> ?", @navigation.template_box]).collect{|b| [b.name, b.id]}
    render :layout => false
  end
  
  def do_move
    @navigation = Navigation.find params[:id]
    @navigation.template_box = TemplateBox.find params[:navigation][:template_box_id]
    if @navigation.save
      flash[:notice] = "Navigation #{@navigation.name} wurde verschoben"
    else
      flash[:error] = "Fehler beim verschieben von Navigation #{@navigation.name}"
    end
    redirect_to edit_box_navigations_path(:template_box_id => params[:template_box_id])
  end
  
  def destroy
    @navigation = Navigation.find params[:id]
    box_id = @navigation.template_box_id
    @navigation.destroy
    redirect_to edit_box_navigations_path(:template_box_id => box_id)
  end
end