class AddMaxListItemsToTemplateArea < ActiveRecord::Migration
  def self.up
    add_column :template_areas, :max_list_items, :integer
  end

  def self.down
    remove_column :template_areas, :max_list_items
  end
end
