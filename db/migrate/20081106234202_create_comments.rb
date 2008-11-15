class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :entry
      t.belongs_to :user, :site#, :news, :guestbook, :profile
      t.references :commentable, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
