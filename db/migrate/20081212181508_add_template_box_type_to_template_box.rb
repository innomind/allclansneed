class AddTemplateBoxTypeToTemplateBox < ActiveRecord::Migration
  def self.up
    add_column :template_boxes, :template_box_type_id, :integer
  end

  def self.down
    remove_column :template_boxes, :template_box_type_id
  end
end
