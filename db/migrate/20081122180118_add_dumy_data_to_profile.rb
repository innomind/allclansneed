class AddDumyDataToProfile < ActiveRecord::Migration
  def self.up
    User.acn_dev_users.each do |user|
      profile = Profile.create(:firstname => user.login)
      user.profile = profile
      user.save
    end
  end

  def self.down
    User.acn_dev_users.each do |user|
      user.profile = nil
      user.save
    end
  end
end