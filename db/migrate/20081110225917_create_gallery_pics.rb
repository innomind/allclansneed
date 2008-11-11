class CreateGalleryPics < ActiveRecord::Migration
  def self.up
    create_table :gallery_pics do |t|
      t.string :pic_file_name
      t.string :pic_content_type
      t.string :pic_file_size
      t.string :name
      t.text :description
      t.belongs_to :site
      t.belongs_to :gallery_category
      t.belongs_to :user
      t.timestamp :pic_updated_at
      t.timestamps
    end
    
    add_column :comments, :gallery_pic_id, :integer
  end

  def self.down
    drop_table :gallery_pics
    remove_column :comments, :gallery_pic_id
  end
end
