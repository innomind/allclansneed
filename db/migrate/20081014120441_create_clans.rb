class CreateClans < ActiveRecord::Migration
  def self.up
    create_table :clans do |t|
      t.string :name, :limit => 80
      t.integer :site_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :clans
  end
end
