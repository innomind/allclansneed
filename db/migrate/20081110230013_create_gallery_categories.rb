class CreateGalleryCategories < ActiveRecord::Migration
  def self.up
    create_table :gallery_categories do |t|
      t.string :name
      t.text :description
      t.belongs_to :user
      t.belongs_to :site

      t.timestamps
    end
  end

  def self.down
    drop_table :gallery_categories
  end
end
