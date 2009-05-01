class CreateTicketMessages < ActiveRecord::Migration
  def self.up
    create_table :ticket_messages do |t|
      t.integer :user_id
      t.integer :ticket_id
      t.string :message
      t.timestamps
    end
  end

  def self.down
    drop_table :ticket_messages
  end
end
