class AddWelcomeMailingToSites < ActiveRecord::Migration
  def self.up
    add_column :sites, :welcome_mailing, :boolean, :default => false
    Site.find(:all).each do |site|
      site.update_attribute("welcome_mailing", false)
    end
  end

  def self.down
    remove_column :sites, :welcome_mailing
  end
end
