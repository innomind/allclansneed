module TemplateBoxesHelper
  def get_boxes_for internal_name
    area = @template_areas.find{|a| a.internal_name == internal_name}
    return(Array('')) if area.nil?
    area.template_boxes
  end
  
  def create_box box, link_style = nil   
    if (box.template_box_type.link_list)
      link_style ||= ["<li>","</li>"] 
      eval("create_#{box.template_box_type.internal_name}_box box")[0..(box.template_area.max_list_items || -0)-1].collect{|link| link_style[0]+link+link_style[1]}.join
    else
      ret = "<div class='box_entry'>"
      ret << render(:partial => "boxes/#{box.template_box_type.internal_name}/show_loader", :locals => {:box => box})
      ret << "</div>"
    end
  end
end
