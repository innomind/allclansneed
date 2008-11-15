class CreateForumThreads < ActiveRecord::Migration
  def self.up
    create_table :forum_threads do |t|
      t.column :title, :string
      t.belongs_to :user
      t.belongs_to :forum
      t.belongs_to :site
      t.timestamps
    end
    
  end

  def self.down
    drop_table :forum_threads
  end
end
