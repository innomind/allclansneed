class AddForumThreadCount < ActiveRecord::Migration
  def self.up
    add_column :forum_categories, :forum_threads_count, :integer
  end

  def self.down
    remove_column :forum_categories, :forum_threads_count
  end
end
