class Template < ActiveRecord::Base
  has_many :sites
  has_many :template_areas, :dependent => :destroy
  
  def move_boxes boxes
    areas_with_prefered = self.template_areas.select{|area| !area.template_box_type.nil?}
    areas_with_prefered.each { |pa| 
      edit_box = boxes.select{|box| box.template_box_type == pa.template_box_type}.first
      edit_box.template_area = pa
      edit_box.save
      boxes = boxes - [edit_box]
    }
    areas = self.template_areas - areas_with_prefered
    boxes_per_area = boxes.size / areas.size
    
    areas.each{|ta| 
      break unless ta.is_addable?
      1.upto(boxes_per_area) {|i|
        box = boxes.first
        box.template_area = ta
        box.save
        boxes = boxes - [box]
      }
    }
    
    last_area = areas.select{|area| area.is_addable? && area.template_box_type.nil?}.first
    boxes.each{|box| box.template_area = last_area; box.save}
  end
end