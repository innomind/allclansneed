class CreateNewsComments < ActiveRecord::Migration
  def self.up
    create_table :news_comments do |t|
      t.column :comment, :text
      t.column :author_id, :integer
      t.belongs_to :news
      t.timestamps
    end
  end

  def self.down
    drop_table :news_comments
  end
end
