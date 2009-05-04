class AlterContentToTextInArticles < ActiveRecord::Migration
  def self.up
    change_column :articles, :content, :text
  end

  def self.down
  end
end
