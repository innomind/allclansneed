class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.string :name
      t.datetime :expire_at
      t.text :description
      t.belongs_to :site
      t.timestamps
    end
  end

  def self.down
    drop_table :events
  end
end