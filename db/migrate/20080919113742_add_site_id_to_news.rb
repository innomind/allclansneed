class AddSiteIdToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :site_id, :integer
  end

  def self.down
    remove_column :news, :site_id
  end
end
