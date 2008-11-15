class CreateGalleryPics < ActiveRecord::Migration
  def self.up
    create_table :gallery_pics do |t|
      t.string :pic_file_name
      t.string :pic_content_type
      t.string :pic_file_size
      t.string :name
      t.text :description
      t.belongs_to :site
      t.belongs_to :gallery
      t.belongs_to :user
      t.timestamp :pic_updated_at
      t.timestamps
    end
  end

  def self.down
    drop_table :gallery_pics
  end
end
