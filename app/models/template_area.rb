class TemplateArea < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :template
  has_many :template_boxes
  has_many :sites, :through => :template_boxes
  
  def self.get_areas_for_site site
    find :all,
      :select => "template_areas.id, template_areas.internal_name,
                  template_boxes.name, template_boxes.id,
                  template_box_types.name, template_box_types.internal_name,
                  navigations.name,
                  navigations_template.controller, navigations_action",
      :conditions => ["template_id = ? AND template_boxes.site_id = ?",site.template_id,site.id],
      :include => [ :template_boxes => 
                        [ :template_box_type, 
                         {:navigations => :navigation_template} ]
                   ],
      :order => "template_areas.position, template_boxes.position, navigations.position"
  end
  
  #returns true if a box can be added to that area
  def is_addable?
    self.multiple_boxes_allowed? ? true : self.template_boxes.empty?
  end
end