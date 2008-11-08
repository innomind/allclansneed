class CreateSquads < ActiveRecord::Migration
  def self.up
    create_table :squads do |t|
      t.string :name, :limit => 80
      t.integer :clan_id
      t.timestamps
    end
  end

  def self.down
    drop_table :squads
  end
end
