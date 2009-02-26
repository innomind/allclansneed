class AddToptextToTemplates < ActiveRecord::Migration
  def self.up
    add_column :templates, :page_text_1, :string
    add_column :templates, :page_text_2, :string
    add_column :templates, :page_text_3, :string
    add_column :templates, :page_text_4, :string
  end

  def self.down
    remove_column :templates, :page_text_1
    remove_column :templates, :page_text_2
    remove_column :templates, :page_text_3
    remove_column :templates, :page_text_4
  end
end
