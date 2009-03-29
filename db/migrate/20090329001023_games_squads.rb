class GamesSquads < ActiveRecord::Migration
  def self.up
    create_table :games_squads do |t|
      t.belongs_to :game, :squad
      t.timestamps
    end
  end

  def self.down
    drop_table :games_squads
  end
end
