class RemoveNewsCategoryIdAndAddCategoryIdFromNews < ActiveRecord::Migration
  def self.up
    remove_column :news, :news_category_id
    add_column :news, :category_id, :integer
  end

  def self.down
    add_column :news, :news_category_id, :integer
    remove_column :news, :category_id
  end
end
