class CreateGuestbooks < ActiveRecord::Migration
  def self.up
    create_table :guestbooks do |t|
      t.string :name, :email
      t.text :entry, :comment
      t.belongs_to :site
      t.integer :comment_author_id
      t.timestamps
    end
  end

  def self.down
    drop_table :guestbooks
  end
end
