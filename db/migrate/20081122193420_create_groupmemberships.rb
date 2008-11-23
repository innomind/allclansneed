class CreateGroupmemberships < ActiveRecord::Migration
  def self.up
    create_table :groupmemberships do |t|
      t.integer :group_id
      t.integer :user_id
      t.string :status
      t.timestamps
    end
  end

  def self.down
    drop_table :groupmemberships
  end
end
