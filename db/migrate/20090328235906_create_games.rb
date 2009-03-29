class CreateGames < ActiveRecord::Migration
  def self.up
    create_table :games do |t|
      #pic
      t.string   :game_pic_file_name
      t.string   :game_pic_content_type 
      t.integer  :game_pic_file_size    
      t.datetime :game_pic_updated_at   
      #icon
      t.string   :game_icon_file_name
      t.string   :game_icon_content_type
      t.integer  :game_icon_file_size
      t.datetime :game_icon_updated_at
      
      t.string :name, :mod
      t.timestamps
    end
  end

  def self.down
    drop_table :games
  end
end
