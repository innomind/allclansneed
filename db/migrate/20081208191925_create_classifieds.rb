class CreateClassifieds < ActiveRecord::Migration
  def self.up
    create_table :classifieds do |t|
      t.string :name
      t.text :description
      t.belongs_to :user
      t.timestamps
    end
  end

  def self.down
    drop_table :classifieds
  end
end
