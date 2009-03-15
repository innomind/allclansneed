class CreateTickets < ActiveRecord::Migration
  def self.up
    create_table :tickets do |t|
      t.integer :admin_id
      t.integer :author_id
      t.string :subject
      t.timestamps
    end
  end

  def self.down
    drop_table :tickets
  end
end
