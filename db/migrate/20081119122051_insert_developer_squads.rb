class InsertDeveloperSquads < ActiveRecord::Migration
  # ok, all this is ugly c-like imperative style (and too complicated), sorry
  def self.up
#     (User.find :all, :conditions => {:login => User.acn_dev_users.collect {|u| u.login}}).each do |user|
#      user.squads.push(squad = Squad.create(:name => (name_squad user)))
#      user.clans_with_site.each do |clan|
#        squad.clan = clan unless clan.site.id == Site::PORTAL_ID
#        unless squad.save
#          puts "error saving squad '#{squad.name}'"
#        end
#      end
#    end
    
  end
  
 # def self.name_squad user
 #   (user.nick[-1,1] == 's')? user.nick+"' coder-squad" : user.nick+"s coder-squad"
 # end

  def self.down
#    (User.find :all, :conditions => {:login => User::ACN_DEV_USERS.collect {|u| u.login}}).each do |user|
#
#      user.squad_users.each do |su|
#
#        if su.squad.name == (name_squad user)
#          Squad.delete su.squad.id
#          SquadUser.delete su.id
#        end
#      end
#      #Squad.delete(:name => user.nick+"s coder-squad", :)
#    end
  end
end
