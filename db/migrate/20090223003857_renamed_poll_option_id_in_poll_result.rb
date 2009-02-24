class RenamedPollOptionIdInPollResult < ActiveRecord::Migration
  def self.up
    remove_column :poll_results, :polloption_id
    add_column :poll_results, :poll_option_id, :integer
  end

  def self.down
    add_column :poll_results, :polloption_id, :integer
    remove_column :poll_results, :poll_option_id
  end
end
