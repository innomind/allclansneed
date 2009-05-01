class AddSupportStatusToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :support_status, :integer
  end

  def self.down
    remove_column :users, :support_status
  end
end
