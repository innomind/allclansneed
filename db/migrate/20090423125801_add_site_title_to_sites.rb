class AddSiteTitleToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :site_title, :string
  end

  def self.down
    remove_column :sites, :site_title
  end
end
