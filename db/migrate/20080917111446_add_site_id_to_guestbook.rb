class AddSiteIdToGuestbook < ActiveRecord::Migration
  def self.up
    add_column :guestbooks, :site_id, :integer
    
    Guestbook.find(:all).each do |t|
      t.update_attribute(:site_id, 1)
    end
  end

  def self.down
    remove_column :guestbooks, :site_id
  end
end
