class AddMultipleBoxesAllowedToTemplateAreas < ActiveRecord::Migration
  def self.up
    add_column :template_areas, :multiple_boxes_allowed, :boolean, :default => true
  end

  def self.down
    remove_column :template_areas, :multiple_boxes_allowed
  end
end
