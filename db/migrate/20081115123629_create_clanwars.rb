class CreateClanwars < ActiveRecord::Migration
  def self.up
    create_table :clanwars do |t|
      t.string :opponent
      t.integer :score
      t.integer :score_opponent
      t.datetime :played_at
      t.belongs_to :squad
      t.belongs_to :site
      t.belongs_to :user
      t.timestamps
    end
  end

  def self.down
    drop_table :clanwars
  end
end
