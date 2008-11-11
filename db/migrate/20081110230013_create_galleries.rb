class CreateGalleries < ActiveRecord::Migration
  def self.up
    create_table :galleries do |t|
      t.string :name
      t.text :description
      t.belongs_to :user
      t.belongs_to :site

      t.timestamps
    end
  end

  def self.down
    drop_table :galleries
  end
end
