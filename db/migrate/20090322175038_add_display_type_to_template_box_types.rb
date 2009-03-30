class AddDisplayTypeToTemplateBoxTypes < ActiveRecord::Migration
  def self.up
    add_column :template_box_types, :link_list, :boolean, :default => false
  end

  def self.down
    remove_column :template_box_types, :link_list
  end
end
