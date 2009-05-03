class AlterMessageToTextInTicketMessage < ActiveRecord::Migration
  def self.up
    change_column :ticket_messages, :message, :text
  end

  def self.down
  end
end
