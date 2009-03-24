class AddRoleToSquadUser < ActiveRecord::Migration
  def self.up
    add_column :squad_users, :role, :string
  end

  def self.down
    remove_column :squad_users, :role
  end
end
