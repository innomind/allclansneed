class CreateForumCategories < ActiveRecord::Migration
  def self.up
    create_table :forum_categories do |t|
      t.column :title, :string
      t.column :subtitle, :string
      t.column :position, :integer
      t.column :parent_id, :integer
      t.column :forum_threads_count, :integer
      t.timestamps
    end
  end

  def self.down
    drop_table :forum_categories
  end
end
