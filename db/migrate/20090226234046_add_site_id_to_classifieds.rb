class AddSiteIdToClassifieds < ActiveRecord::Migration
  def self.up
    add_column :classifieds, :site_id, :integer
  end

  def self.down
    remove_column :classifieds, :site_id
  end
end
