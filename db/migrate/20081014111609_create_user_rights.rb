class CreateUserRights < ActiveRecord::Migration
  def self.up
    create_table :user_rights do |t|
      t.integer :site_id
      t.integer :user_id
      t.integer :level
      t.timestamps
    end
  end

  def self.down
    drop_table :user_rights
  end
end
