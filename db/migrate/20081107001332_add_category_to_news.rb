class AddCategoryToNews < ActiveRecord::Migration
  def self.up
    add_column :news, :news_category, :integer
  end

  def self.down
    remove_column :news, :news_category
  end
end
