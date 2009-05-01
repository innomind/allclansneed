class AddAccountTypeToTemplates < ActiveRecord::Migration
  def self.up
    add_column :templates, :account_type, :string, :default => "free"
  end

  def self.down
    remove_column :templates, :account_type
  end
end
