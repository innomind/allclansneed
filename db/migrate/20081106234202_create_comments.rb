class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :entry
      t.belongs_to :site, :user, :news, :guestbook, :profile
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
