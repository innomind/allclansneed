module SquadUserHelper
  def target_squads_from squad
    Clan.current.squads.select { |sq| sq != squad }
  end
end
