class AddSquadsCountAndMemberCountToClans < ActiveRecord::Migration
  def self.up
    add_column :clans, :squads_count, :integer, :default => 0
    add_column :clans, :members_count, :integer, :default => 0
  end

  def self.down
    remove_column :clans, :members_count
    remove_column :clans, :squads_count
  end
end
