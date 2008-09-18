class AddMaskToAccount < ActiveRecord::Migration
  def self.up
    add_column :accounts, :mask, :binary
  end

  def self.down
    remove_column :accounts, :mask
  end
end
