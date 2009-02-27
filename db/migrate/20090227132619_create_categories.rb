class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :position
      t.belongs_to :site
      t.string :controller
      t.timestamps
    end
  end

  def self.down
    drop_table :categories
  end
end
