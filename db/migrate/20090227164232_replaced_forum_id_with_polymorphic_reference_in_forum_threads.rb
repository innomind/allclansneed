class ReplacedForumIdWithPolymorphicReferenceInForumThreads < ActiveRecord::Migration
  def self.up
    remove_column :forum_threads, :forum_id
    add_column :forum_threads, :threadable_type, :string
    add_column :forum_threads, :threadable_id, :integer
  end

  def self.down
    add_column :forum_threads, :forum_id, :integer
    remove_column :forum_threads, :threadable_type
    remove_column :forum_threads, :threadable_id
  end
end
