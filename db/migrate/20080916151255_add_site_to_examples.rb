class AddSiteToExamples < ActiveRecord::Migration
  def self.up
    add_column :examples, :site_id, :integer
    Example.create :title => "test1", :content => "content in page 1", :site_id => 1
    Example.create :title => "test2", :content => "content in page 2", :site_id => 2
  end

  def self.down
    remove_column :examples, :site_id
    Example.delete(Example.all :title => 'test1')
    Example.delete(Example.all :title => 'test2')
  end
end
