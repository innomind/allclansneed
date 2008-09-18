class NewsCategoryJoin < ActiveRecord::Migration
  def self.up
    create_table 'news_news_categories', :id  => false do |t|
      t.column 'news_category_id', :integer
      t.column 'news_id', :integer
    end
  end

  def self.down
    drop_table 'news_news_categories'
  end
end
