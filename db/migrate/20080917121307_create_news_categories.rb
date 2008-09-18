class CreateNewsCategories < ActiveRecord::Migration
  def self.up
    
    create_table :news_categories do |t|
      t.column :name, :string
      t.timestamps
    end
    
    add_column :news, :news_category_id, :integer
    
#    NewsCategory.create :name => "Allgemeines"
#    NewsCategory.create :name => "Spezielles"
    
    News.all.each do |n|
      n.update_attribute(:news_category_id, 1)
    end
    
  end

  def self.down
    remove_column :news, :news_categories_id
    drop_table :news_categories
  end
end
