class AddOrderToCategories < ActiveRecord::Migration
  def self.up
    add_column :categories, :position, :integer
    Category.find(:all).each do |c|
      c.update_attribute(:position, 1)
    end
  end

  def self.down
    remove_column :categories, :position
  end
end
