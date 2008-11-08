class CreatePinwalls < ActiveRecord::Migration
  def self.up
    create_table :pinwalls do |t|
      t.string :entry
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :pinwalls
  end
end
