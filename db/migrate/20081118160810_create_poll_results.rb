class CreatePollResults < ActiveRecord::Migration
  def self.up
    create_table :poll_results do |t|
      t.belongs_to :polloption
      t.belongs_to :poll
      t.belongs_to :user
      t.timestamps
    end
  end

  def self.down
    drop_table :poll_results
  end
end
