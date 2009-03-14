class AddResponseToDaemonTask < ActiveRecord::Migration
  def self.up
    add_column :daemon_tasks, :response, :string
  end

  def self.down
    remove_column :daemon_tasks, :response
  end
end
