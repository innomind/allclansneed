class CreateGroups < ActiveRecord::Migration
  def self.up
    create_table :groups do |t|
      t.string :name
      t.text :description
      t.boolean :moderated, :default => false
      t.integer :founder_id
      t.timestamps
    end
  end

  def self.down
    drop_table :groups
  end
end
