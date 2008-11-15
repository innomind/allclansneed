namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    require 'populator'
    require 'faker'
    
    [Squad, Clanwar, ClanwarMap].each(&:delete_all)
    
    site = Site.find_by_id(2)
    
    Squad.populate 3 do |squad|
      squad.name = Populator.words(1..3).titleize
      squad.clan_id = 1
      Clanwar.populate 5..10 do |clanwar|
        clanwar.squad_id = squad.id
        clanwar.site_id = site.id
        clanwar.user_id = [1, 2, 3]
        clanwar.score = 0
        clanwar.score_opponent = 0
        clanwar.opponent = Populator.words(3..5).titleize
        clanwar.played_at = 2.years.from_now..Time.now
        ClanwarMap.populate 1..3 do |map|
          map.clanwar_id = clanwar.id
          map.score = [1,2,3,4,5,6,7,8,9,10]
          map.score_opponent = [1,2,3,4,5,6,7,8,9,10]
          clanwar.score += map.score
          clanwar.score_opponent += map.score_opponent
          map.name = Populator.words(1)
        end
      end
    end
  end
end