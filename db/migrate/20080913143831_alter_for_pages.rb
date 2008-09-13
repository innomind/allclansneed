class AlterForPages < ActiveRecord::Migration
  def self.up
    
    Page.create :title => "First page"
    add_column :classifieds, :page_id, :integer
    add_column :categories, :page_id, :integer
    
    Classified.find(:all).each do |c|
      c.update_attribute(:page_id, 1)
    end
    
    Category.find(:all).each do |c|
      c.update_attribute(:page_id, 1)
    end
    
  end

  def self.down
    remove_column :classifieds, :page_id
    remove_column :categories, :page_id
  end
end
