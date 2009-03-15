class AddSectionToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :section, :string
  end

  def self.down
    remove_column :categories, :section
  end
end
