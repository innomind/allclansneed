class TemplateBoxesController < ApplicationController

  before_filter :init_template_areas
  before_filter :init_box, :only => [:edit, :update, :move, :do_move, :delete]
  
  add_breadcrumb 'Boxen bearbeiten', "boxes_path"
  
  def index
    
  end

  def new
    new_boxes = TemplateBoxType.find :all, 
      :select => "name, id",
      :conditions => ["multiple_allowed = ? OR id NOT IN (?)",
      true,
      get_box_type_list]
    @boxes = new_boxes.collect{|b| [b.name, b.id]}
    render :layout => false
  end
  
  def create
    @area = TemplateArea.find_by_id params[:template_area_id].to_i
    unless @area.is_addable?
      flash[:error] = @area.name + "darf nur eine Box haben"
      redirect_to :action => "index" and return
    end
    
    @box = TemplateBox.new(params[:template_box])
    @box.site = current_site
    @box.template_area_id = params[:template_area_id]
    # dryed a little ;)
    flash[:error] = @box.errors.full_messages.join("<br>") unless @box.save
    redirect_to :action => "index"
  end
  
  def edit
    render :layout => false
  end

  def update
    @box.name = params[:template_box][:name]
    flash[:error] = @box.errors.full_messages.join("<br>") unless @box.save
    redirect_to :action => "index"
  end

  #TODO Security lack man kann boxen von anderen seiten sortieren
  def update_positions
    params["edit_template_area_#{params[:id]}"].each_with_index do |id, position|
      TemplateBox.update(id, :position => position)
    end
    init_template_areas
    #render :layout => false,
    #  :partial => "template_area",
    #  :object => @template_areas.find{|a| a.id == params[:id].to_i} #TODO Dry it
    render :update do |page|
      page.replace_html(:update_message, "<div id='update_message'>Änderungen wurden gespeichert, aber werden erst nach einem Reload sichtbar</div>")
      page.visual_effect(:highlight, :update_message)
    end
  end
  
  def move
    areas = @template_areas.select{|a| a.is_addable?}-[@box.template_area]
    @areas = areas.collect{|a| [a.name, a.id]}
    render :layout => false
  end
  
  def do_move
    @box.update_attribute(:template_area_id, params[:template_box][:template_area_id].to_i)
    @box.update_attribute(:position, nil)
    redirect_to :action => "index"
  end
  
  def delete
    @box.destroy
    redirect_to :action => "index"
  end
  
  private
  
  def init_box
    @box = TemplateBox.find_by_id params[:template_box_id].to_i
  end
  
  def init_template_areas
    init_areas true
    @all_areas = TemplateArea.find_all_by_template_id current_site.template_id
    @template_areas = @template_areas.concat(@all_areas).uniq
  end

  #not used anymore - del?
  def get_area
    template_area = TemplateArea.find :first, 
      :conditions => ["template_id = ? AND template_areas.id = ? AND tempalte_boxes.site_id = ?",
      current_site.template_id,
      params[:id],
      current_site.id ],
      :include => [ :template_boxes => :template_box_type ],
      :order => "template_areas.position, template_boxes.position"
    render :layout => false, :partial => "template_area", :object => template_area
  end
  
  def get_box_type_list
    init_template_areas
    b = Array('')
    @template_areas.each {|a| a.template_boxes.each {|box| b.push box.template_box_type_id}}
    b.uniq
  end
end