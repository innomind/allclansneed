class AlterMottoToTextInProfiles < ActiveRecord::Migration
  def self.up
    change_column :profiles, :motto, :text
  end

  def self.down
    #change_column :profiles, :motto, :string
  end
end
