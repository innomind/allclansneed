class TemplateBoxesController < ApplicationController
  #before_filter :init_template_areas  
  
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
    @box = TemplateBox.new(params[:template_box])
    @box.site = current_site
    @box.template_area_id = params[:template_area_id]
    if @box.save
      redirect_to :action => "index"
    end
  end
  
  def edit
    render :layout => false, :text => "hallo"
  end

  def update
    
  end

  def update_positions
    params["template_area_" + params[:id]].each_with_index do |id, position|
      TemplateBox.update(id, :position => position)
    end
    debugger
    init_areas true
    
    render :layout => false,
           :partial => "template_area", 
           :object => @template_areas.find{|a| a.id == params[:id].to_i}
  end
  
  private
  
  def init_template_areas
      init_areas true if request.xhr?
  end
  
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
    b = Array('')
    @template_areas.each {|a| a.template_boxes.each {|box| b.push box.template_box_type_id}}
    b.uniq
  end
end