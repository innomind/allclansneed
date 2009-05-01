class CreateClanJoinInquiries < ActiveRecord::Migration
  def self.up
    create_table :clan_join_inquiries do |t|
      t.text :inquiry_text
      t.belongs_to :clan, :user
      t.timestamps
    end
  end

  def self.down
    drop_table :clan_join_inquiries
  end
end
