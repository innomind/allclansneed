class AddThreadsCountToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :threads_count, :integer, :default => 0
  end

  def self.down
    remove_column :groups, :threads_count
  end
end
