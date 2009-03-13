class CreateShoutboxes < ActiveRecord::Migration
  def self.up
    create_table :shoutboxes do |t|
      t.integer :user_id
      t.integer :site_id
      t.string :content
      t.timestamps
    end
  end

  def self.down
    drop_table :shoutboxes
  end
end
