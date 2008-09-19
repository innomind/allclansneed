class AddUserToAndRemoveManyAttrsFromAccount < ActiveRecord::Migration
  
  def self.up
    remove_column :accounts, :email
    remove_column :accounts, :firstname
    remove_column :accounts, :lastname
    remove_column :accounts, :password
    add_column :accounts, :user_id, :int
  end

  def self.down
    add_column :accounts, :email, :string
    add_column :accounts, :firstname, :string
    add_column :accounts, :lastname, :string
    add_column :accounts, :password, :string
    remove_column :user_id
  end
end
