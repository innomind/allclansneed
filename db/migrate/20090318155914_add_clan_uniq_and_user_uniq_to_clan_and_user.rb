class AddClanUniqAndUserUniqToClanAndUser < ActiveRecord::Migration
  def self.up
    add_column :clans, :uniq, :string
  end

  def self.down
    remove_column :clans, :uniq
  end
end
