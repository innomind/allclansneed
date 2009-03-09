class RenamedForumThreadsCountToThreadsCountInForums < ActiveRecord::Migration
  def self.up
    rename_column :forums, :forum_threads_count, :threads_count
  end

  def self.down
    rename_column :forums, :threads_count, :forum_threads_count
  end
end
