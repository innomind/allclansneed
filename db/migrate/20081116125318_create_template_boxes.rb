class CreateTemplateBoxes < ActiveRecord::Migration
  def self.up
    create_table :template_boxes do |t|
      t.string :name
      t.integer :position
      t.belongs_to :template_area
      t.belongs_to :site
      t.timestamps
    end
  end

  def self.down
    drop_table :template_boxes
  end
end
