class InsertExampleEntries < ActiveRecord::Migration
  def self.up
    Example.new(:title => 'title 1', :content => 'blabla 1111', :site_id => 1).save
    Example.new(:title => 'title 2', :content => 'blabla 2222', :site_id => 2).save
  end

  def self.down
    Example.delete(Example.all, :title => 'title 1')
    Example.delete(Example.all, :title => 'title 2')
  end
end
