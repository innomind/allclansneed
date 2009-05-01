class AddMessageCounterToTickets < ActiveRecord::Migration
  def self.up
    add_column :tickets, :ticket_messages_count, :integer
  end

  def self.down
    remove_column :tickets, :ticket_messages_count
  end
end
