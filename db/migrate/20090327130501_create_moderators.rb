class CreateModerators < ActiveRecord::Migration
  def self.up
    create_table :moderators do |t|
      t.integer :user_id
      t.integer :site_id
      t.integer :forum_id
      t.timestamps
    end
  end

  def self.down
    drop_table :moderators
  end
end
