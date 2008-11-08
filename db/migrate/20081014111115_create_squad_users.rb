class CreateSquadUsers < ActiveRecord::Migration
  def self.up
    create_table :squad_users do |t|
      t.integer :squad_id
      t.integer :user_id
      t.timestamps
    end
  end

  def self.down
    drop_table :squad_users
  end
end
