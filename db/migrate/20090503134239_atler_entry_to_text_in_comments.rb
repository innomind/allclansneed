class AtlerEntryToTextInComments < ActiveRecord::Migration
  def self.up
    change_column :comments, :entry, :text
  end

  def self.down
  end
end
