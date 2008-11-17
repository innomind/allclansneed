class AddTemplateToSite < ActiveRecord::Migration
  def self.up
    add_column :sites, :template_id, :integer
  end

  def self.down
    remove_column :sites, :template_id
  end
end
