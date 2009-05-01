class AddCounterCacheToForumThreads < ActiveRecord::Migration
  def self.up
    add_column :forum_threads, :forum_messages_count, :integer, :default => 0
  end

  def self.down
    remove_column :forum_threads, :forum_messages_count
  end
end
