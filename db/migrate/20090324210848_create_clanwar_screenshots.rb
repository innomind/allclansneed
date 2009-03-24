class CreateClanwarScreenshots < ActiveRecord::Migration
  def self.up
    create_table :clanwar_screenshots do |t|
      t.string :screenshot_file_name, :screenshot_content_type
      t.integer :screenshot_file_size
      t.datetime :screenshot_updated_at
      t.belongs_to :clanwar, :user
      t.timestamps
    end
  end

  def self.down
    drop_table :clanwar_screenshots
  end
end
