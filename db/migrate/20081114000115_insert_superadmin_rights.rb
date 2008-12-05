class InsertSuperadminRights < ActiveRecord::Migration
  def self.up
    admin = User.find_by_login 'superadmin'
    Site.all.each { |site| admin.user_rights.push UserRight.create(:site => site, :right_type => User::SITE_MEMBER)}
    #puts "ERROR: Can't save superadmin sites/user_rights" unless admin.save
    admin.user_rights.all.each do |ur|
      Component.all.each do |comp|
        ur.components.push comp
      end
    end
    puts "ERROR: Can't save superadmin component rights"+(admin.errors.map {|f,e| f+": "+e+"\n"}).join unless admin.save
  end

  
  def self.down
    admin = User.find_by_login 'superadmin'
    admin.user_rights = []
    admin.right_components = []
    puts "ERROR: Can't save superadmin rights" unless admin.save
  end

end
