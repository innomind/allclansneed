class CreateTemplateBoxTypes < ActiveRecord::Migration
  def self.up
    create_table :template_box_types do |t|
      t.string :name, :internal_name
      t.boolean :editable, :multiple_allowed
      t.belongs_to :component
      t.timestamps
    end
  end

  def self.down
    drop_table :template_box_types
  end
end
