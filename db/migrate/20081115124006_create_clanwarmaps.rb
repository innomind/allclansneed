class CreateClanwarmaps < ActiveRecord::Migration
  def self.up
    create_table :clanwarmaps do |t|
      t.string :name
      t.integer :score
      t.integer :score_opponent
      t.belongs_to :clanwar
      t.timestamps
    end
  end

  def self.down
    drop_table :clanwarmaps
  end
end
