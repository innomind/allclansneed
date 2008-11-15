class CreateForumMessages < ActiveRecord::Migration
  def self.up
    create_table :forum_messages do |t|
      t.column :message, :text
      t.belongs_to :user
      t.belongs_to :forum_thread
      t.belongs_to :site
      t.timestamps
    end
  end

  def self.down
    drop_table :forum_messages
  end
end
