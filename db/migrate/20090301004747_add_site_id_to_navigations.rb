class AddSiteIdToNavigations < ActiveRecord::Migration
  def self.up
    add_column :navigations, :site_id, :integer
  end

  def self.down
    remove_column :navigations, :site_id
  end
end
