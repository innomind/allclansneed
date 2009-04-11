class AddCounterCacheToSquads < ActiveRecord::Migration
  def self.up
    add_column :squads, :squad_users_count, :integer
  end

  def self.down
    remove_column :squads, :squad_users_count
  end
end
