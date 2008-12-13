class RemoveControllerAndActionFromNavigations < ActiveRecord::Migration
  def self.up
    remove_column :navigations, :controller
    remove_column :navigations, :action
  end

  def self.down
    add_column :navigations, :controller, :string
    add_column :navigations, :action, :string
  end
end
