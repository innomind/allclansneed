class AddSomeAttrsToUser < ActiveRecord::Migration
  def self.up
      add_column :users, :firstname, :string
      add_column :users, :lastname, :string
      remove_column :users, :password
      add_column :users, :password, :string, :limit => 64
  end

  def self.down
    remove_column :users, :firstname
    remove_column :users, :lastname
    
  end
end
