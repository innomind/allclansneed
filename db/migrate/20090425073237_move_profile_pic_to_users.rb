class MoveProfilePicToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :profile_pic_file_name, :string
    add_column :users, :profile_pic_content_type, :string
    add_column :users, :profile_pic_file_size, :integer
    add_column :users, :profile_pic_updated_at, :datetime
    
    Profile.all do |profile|
      profile.user.update_attribute("profile_pic_file_name",    profile.profile_pic_file_name   )
      profile.user.update_attribute("profile_pic_content_type", profile.profile_pic_content_type)
      profile.user.update_attribute("profile_pic_file_size",    profile.profile_pic_file_size   )
      profile.user.update_attribute("profile_pic_updated_at",   profile.profile_pic_updated_at  )
    end
    
    remove_column :profiles, :profile_pic_updated_at
    remove_column :profiles, :profile_pic_file_size
    remove_column :profiles, :profile_pic_content_type
    remove_column :profiles, :profile_pic_file_name
  end

  def self.down
    add_column :profiles, :profile_pic_file_name, :string
    add_column :profiles, :profile_pic_content_type, :string
    add_column :profiles, :profile_pic_file_size, :integer
    add_column :profiles, :profile_pic_updated_at, :datetime
    
    User.all do |user|
      user.profile.update_attribute("profile_pic_file_name",    user.profile_pic_file_name   )
      user.profile.update_attribute("profile_pic_content_type", user.profile_pic_content_type)
      user.profile.update_attribute("profile_pic_file_size",    user.profile_pic_file_size   )
      user.profile.update_attribute("profile_pic_updated_at",   user.profile_pic_updated_at  )
    end
    
    remove_column :users, :profile_pic_updated_at
    remove_column :users, :profile_pic_file_size
    remove_column :users, :profile_pic_content_type
    remove_column :users, :profile_pic_file_name
  end
end
