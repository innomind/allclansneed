class AddInformationsToProfile < ActiveRecord::Migration
  def self.up
    add_column :profiles, :motto, :string
    add_column :profiles, :bday, :date
    add_column :profiles, :icq, :string
    add_column :profiles, :msn, :string
    add_column :profiles, :skype, :string
    add_column :profiles, :interests, :text
    add_column :profiles, :hardware, :text
    add_column :profiles, :custom_field1_title, :string
    add_column :profiles, :custom_field1, :text
    add_column :profiles, :custom_field2_title, :string
    add_column :profiles, :custom_field2, :text
    add_column :profiles, :custom_field3_title, :string
    add_column :profiles, :custom_field3, :text
  end

  def self.down
    remove_column :profiles, :custom_field3
    remove_column :profiles, :custom_field3_title
    remove_column :profiles, :custom_field2
    remove_column :profiles, :custom_field2_title
    remove_column :profiles, :custom_field1
    remove_column :profiles, :custom_field1_title
    remove_column :profiles, :hardware
    remove_column :profiles, :interests
    remove_column :profiles, :skype
    remove_column :profiles, :msn
    remove_column :profiles, :icq
    remove_column :profiles, :bday
    remove_column :profiles, :motto
  end
end
