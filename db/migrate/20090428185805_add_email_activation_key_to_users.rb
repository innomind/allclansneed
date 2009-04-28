class AddEmailActivationKeyToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :email_activation_key, :string
  end

  def self.down
    remove_column :users, :email_activation_key
  end
end