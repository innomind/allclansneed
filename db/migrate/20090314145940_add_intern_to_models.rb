class AddInternToModels < ActiveRecord::Migration
  def self.up
    add_column :news, :intern, :boolean, :default => false
    add_column :categories, :intern, :boolean, :default => false
    add_column :forum_threads, :intern, :boolean, :default => false
    add_column :forums, :intern, :boolean, :default => false
    add_column :forum_messages, :intern, :boolean, :default => false
    add_column :galleries, :intern, :boolean, :default => false
    add_column :gallery_pics, :intern, :boolean, :default => false
    add_column :articles, :intern, :boolean, :default => false
    add_column :events, :intern, :boolean, :default => false
    add_column :polls, :intern, :boolean, :default => false
    add_column :comments, :intern, :boolean, :default => false
  end

  def self.down
    remove_column :comments, :intern
    remove_column :polls, :intern
    remove_column :events, :intern
    remove_column :articles, :intern
    remove_column :gallery_pics, :intern
    remove_column :galleries, :intern
    remove_column :forum_messages, :intern
    remove_column :forums, :intern
    remove_column :categories, :intern
    remove_column :forum_threads, :intern
    remove_column :categories, :intern
    remove_column :news, :intern
  end
end
