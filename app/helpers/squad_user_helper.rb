module SquadUserHelper
  def target_squads_from squad
    Clan.current.squads.select { |sq| sq != squad }
  end

  #perhaps session would be better...
  def keep item
    case item
    when :target_squad
      hidden_field_tag :target_squad, @target_squad.id
    when :squad
      hidden_field_tag :squad_id, @squad.id
    when :user
      hidden_field_tag :user_id, @user.id
    end
  end
end