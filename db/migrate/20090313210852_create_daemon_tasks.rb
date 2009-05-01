class CreateDaemonTasks < ActiveRecord::Migration
  def self.up
    create_table :daemon_tasks do |t|
      t.string :task
      t.string :domain
      t.time :scheduled_at
      t.time :processed_at
      t.timestamps
    end
  end

  def self.down
    drop_table :daemon_tasks
  end
end
