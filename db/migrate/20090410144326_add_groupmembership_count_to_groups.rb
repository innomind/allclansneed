class AddGroupmembershipCountToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :groupmemberships_count, :integer
  end

  def self.down
    remove_column :groups, :groupmemberships_count
  end
end
