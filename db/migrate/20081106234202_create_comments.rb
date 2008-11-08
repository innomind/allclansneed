class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :comment
      t.belongs_to :site, :user, :news, :guestbook, :pinwall
      t.timestamps
    end
    
  end

  def self.down
    drop_table :comments
  end
end
