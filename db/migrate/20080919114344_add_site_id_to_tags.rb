class AddSiteIdToTags < ActiveRecord::Migration
  def self.up
    add_column :tags, :site_id, :integer
  end

  def self.down
    remove_column :tags, :site_id
  end
end
