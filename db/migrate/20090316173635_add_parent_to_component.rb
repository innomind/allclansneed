class AddParentToComponent < ActiveRecord::Migration
  def self.up
    add_column :components, :parent_id, :integer
  end

  def self.down
    remove_column :components, :parent_id
  end
end
