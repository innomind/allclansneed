class AlterForSites < ActiveRecord::Migration
  def self.up
    
    Site.create :title => "First page"
    Site.create :title => "2nd Page"
    add_column :classifieds, :site_id, :integer
    add_column :categories, :site_id, :integer
    
    Classified.find(:all).each do |c|
      c.update_attribute(:site_id, 1)
    end
    
    Category.find(:all).each do |c|
      c.update_attribute(:site_id, 1)
    end
    
  end

  def self.down
    remove_column :classifieds, :site_id
    remove_column :categories, :site_id
  end
end
