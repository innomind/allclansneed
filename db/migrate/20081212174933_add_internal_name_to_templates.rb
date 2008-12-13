class AddInternalNameToTemplates < ActiveRecord::Migration
  def self.up
    add_column :templates, :internal_name, :string
  end

  def self.down
    remove_column :templates, :internal_name
  end
end
