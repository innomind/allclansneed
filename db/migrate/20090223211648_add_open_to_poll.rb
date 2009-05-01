class AddOpenToPoll < ActiveRecord::Migration
  def self.up
    add_column :polls, :open, :boolean, :default => true
  end

  def self.down
    remove_column :polls, :open
  end
end
