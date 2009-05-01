class AddStatusIdAndCategoryIdToTicket < ActiveRecord::Migration
  def self.up
    add_column :tickets, :status_id, :integer
    add_column :tickets, :category_id, :string
  end

  def self.down
    remove_column :tickets, :status_id, :integer
    remove_column :tickets, :category_id
  end
end
