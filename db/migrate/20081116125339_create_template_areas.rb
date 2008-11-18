class CreateTemplateAreas < ActiveRecord::Migration
  def self.up
    create_table :template_areas do |t|
      t.string :name, :internal_name
      t.integer :position
      t.belongs_to :template
      t.timestamps
    end
  end

  def self.down
    drop_table :template_areas
  end
end
