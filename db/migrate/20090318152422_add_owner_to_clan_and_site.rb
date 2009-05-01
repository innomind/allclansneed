class AddOwnerToClanAndSite < ActiveRecord::Migration
  def self.up
    add_column :clans, :owner_id, :integer
    add_column :sites, :owner_id, :integer
  end

  def self.down
    remove_column :sites, :owner_id
    remove_column :clans, :owner_id
  end
end
