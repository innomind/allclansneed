class RemoveMaskAddRightToAccount < ActiveRecord::Migration
  def self.up
    remove_column :accounts, :mask
    add_column :accounts, :right, :string
  end

  def self.down
    add_column :accounts, :mask, :binary
    column :accounts, :right
  end
end
