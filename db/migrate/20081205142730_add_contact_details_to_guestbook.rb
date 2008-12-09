class AddContactDetailsToGuestbook < ActiveRecord::Migration
  def self.up
    add_column :guestbooks, :url, :string
  end

  def self.down
    remove_column :guestbooks, :url
  end
end
