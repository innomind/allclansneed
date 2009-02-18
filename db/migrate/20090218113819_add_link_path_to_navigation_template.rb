class AddLinkPathToNavigationTemplate < ActiveRecord::Migration
  def self.up
    add_column :navigation_templates, :link_path, :string
  end

  def self.down
    remove_column :navigation_templates, :link_path
  end
end
