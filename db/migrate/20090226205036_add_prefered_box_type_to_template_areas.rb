class AddPreferedBoxTypeToTemplateAreas < ActiveRecord::Migration
  def self.up
    add_column :template_areas, :prefered_box_type_id, :integer
  end

  def self.down
    remove_column :template_areas, :prefered_box_type_id
  end
end
