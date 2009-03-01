class AddEditInNewWindowToTemplateBoxType < ActiveRecord::Migration
  def self.up
    add_column :template_box_types, :edit_in_new_window, :boolean, :default => false
  end

  def self.down
    remove_column :template_box_types, :edit_in_new_window
  end
end
