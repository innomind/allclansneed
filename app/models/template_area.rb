class TemplateArea < ActiveRecord::Base
  #acts_as_delegatable
  belongs_to :template
  belongs_to :template_box_type, :foreign_key => :prefered_box_type_id
  has_many :template_boxes, :dependent => :destroy
  has_many :sites, :through => :template_boxes
  
  def self.get_areas_for_site site
    find :all,
      :select => "template_areas.id, template_areas.internal_name,
                  template_boxes.name, template_boxes.id,
                  template_box_types.name, template_box_types.internal_name,
                  navigations.name,
                  navigations_template.controller, navigations_action,
                  navigations_template.link_path",
      :conditions => ["template_id = ? AND template_boxes.site_id = ?",site.template_id,site.id],
      :include => [ :template_boxes => 
                        [ :template_box_type, 
                         {:navigations => [:navigation_template, :page]} ]
                   ],
      :order => "template_areas.position, template_boxes.position, navigations.position"
  end
  
  #returns true if a box can be added to that area
  def is_addable?
    self.multiple_boxes_allowed? ? true : (TemplateBox.find_all_by_template_area_id(self.id)).empty?
  end
end