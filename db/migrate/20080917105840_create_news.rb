class CreateNews < ActiveRecord::Migration
  def self.up
    create_table :news do |t|
      t.column :title, :string
      t.column :subtext, :text
      t.column :news, :text
      t.timestamps
    end
    
    News.create :title => "Meine erste News", :subtext => "Mein erster Subtext", :news => "Mein erster Newstext"
    News.create :title => "Meine zweite News", :subtext => "Mein zweiter Subtext", :news => "Mein zweiter Newstext"
    
  end

  def self.down
    drop_table :news
  end
end
