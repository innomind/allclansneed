class AddClanTagToClans < ActiveRecord::Migration
  def self.up
    add_column :clans, :clan_tag, :string
    add_column :clans, :description, :text
  end

  def self.down
    remove_column :clans, :description
    remove_column :clans, :clan_tag
  end
end
