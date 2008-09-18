class CreateNewsEntries < ActiveRecord::Migration
  def self.up
    cat = NewsCategory.new :name => 'Kategorie 1'
    cat.save
    
    news = News.new :title => 'test1', :subtext => 'blabla', :news => 'neue Nachrichten'
    news.news_categories = [cat]
    news.save
  end

  def self.down
  end
end
