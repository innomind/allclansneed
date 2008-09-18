class CreateNewsEntries < ActiveRecord::Migration
  def self.up
    
    News.create :title => 'test1', :subtext => 'blabla', :news => 'neue Nachrichten'
  end

  def self.down
  end
end
