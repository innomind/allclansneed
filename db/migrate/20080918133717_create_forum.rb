class CreateForum < ActiveRecord::Migration
  def self.up
    create_table :forums do |t|
      t.column :title, :string
      t.column :subtitle, :string
      t.column :position, :integer
      t.column :parent_id, :integer
      t.column :forum_threads_count, :integer
      t.belongs_to :site
      t.timestamps
    end
  end

  def self.down
    drop_table :forums
  end
end
