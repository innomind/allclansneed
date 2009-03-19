module SquadHelper
  def squads_path
    {:controller => "squad", :action => "index", :clan_id => params[:clan_id]}
  end    
  
  def squad_path id
    {:controller => "squad", :action => "show", :clan_id => params[:clan_id], :id => id}
  end
  
  def new_squad_path
    {:controller => "squad", :action => "new", :clan_id => params[:clan_id]}
  end
  
  def edit_squad_path id
    {:controller => "squad", :action => "edit", :clan_id => params[:clan_id], :id => id}
  end
end
