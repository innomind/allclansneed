class AddVoteCountToPoll < ActiveRecord::Migration
  def self.up
    add_column :polls, :vote_count, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :polls, :vote_count
  end
end
