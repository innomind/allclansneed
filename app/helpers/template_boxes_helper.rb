module TemplateBoxesHelper
  def get_boxes_for internal_name, force = false
    area = @template_areas.find{|a| a.internal_name == internal_name}
    if area.nil?
      ret = [] 
    else
      ret = area.template_boxes
    end
    return [TemplateArea.new(:name => "&nbsp;")] if ret.empty? && force
    return ret
  end
  
  def create_box box, link_style = nil, entry_style = nil
    return "&nbsp;" if box.nil?
    if (box.template_box_type.link_list)
      around = ["<div class='box_entry'><ul class=\"link_list\">","</ul></div>"] if link_style.nil?
      around ||= ["",""]
      link_style ||= ["<li>","</li>"]
      i = 0
      out = around[0]
      out << eval("create_#{box.template_box_type.internal_name}_box box")[0..(box.template_area.max_list_items || -0)-1].collect{ |link|
        if link_style.count == 3
          i += 1
          index = (i%2 == 1) ? 0 : 1
        else
          index = 0
        end 
        link_style[index]+link+link_style.last
      }.join
      out << around[1]
    else
      entry_style ||= ["<div class='box_entry'>", "</div>"]
      ret = entry_style[0]
      ret << render(:partial => "boxes/#{box.template_box_type.internal_name}/show_loader", :locals => {:box => box})
      ret << entry_style[1]
    end
  end
end
