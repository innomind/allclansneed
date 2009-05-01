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
  
#  def squad_users_path squad
#    {:controller => "squad_user", :action => "index", :clan_id => params[:clan_id], :squad_id => squad}
#  end
#  
#  def new_squad_user_path squad
#    {:controller => "squad_user", :action => "new", :clan_id => params[:clan_id], :squad_id => squad}
#  end  
#
#  def edit_user_path id, squad
#    {:controller => "squad_user", :action => "edit", :clan_id => params[:clan_id], :squad_id => squad, :id => id}
#  end
#  
#  def destroy_form_user_path id, squad
#    {:controller => "squad_user", :action => "destroy_form", :clan_id => params[:clan_id], :squad_id => squad, :id => id}
#  end
#  
#  def move_user_path id, squad
#    {:controller => "squad_user", :action => "move", :clan_id => params[:clan_id], :squad_id => squad, :id => id}
#  end
#  
#  def copy_user_path id, squad
#    {:controller => "squad_user", :action => "copy", :clan_id => params[:clan_id], :squad_id => squad, :id => id}
#  end
#  
#  def do_copy_user_path id, squad
#    {:controller => "squad_user", :action => "do_copy", :clan_id => params[:clan_id], :squad_id => squad, :id => id}
#  end
#  
#  def do_move_user_path id, squad
#    {:controller => "squad_user", :action => "do_move", :clan_id => params[:clan_id], :squad_id => squad, :id => id}
#  end
#  
#  def user_path id, squad
#    {:controller => "squad_user", :action => "show", :clan_id => params[:clan_id], :squad_id => squad, :id => id}
#  end
    
end