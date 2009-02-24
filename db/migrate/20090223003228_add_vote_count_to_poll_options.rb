class AddVoteCountToPollOptions < ActiveRecord::Migration
  def self.up
    add_column :poll_options, :vote_count, :integer, :null => false, :default => 0
  end

  def self.down
    remove_column :poll_options, :vote_count
  end
end
