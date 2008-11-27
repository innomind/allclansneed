module ClanManagementHelper
  #def list_squads clan
  #  clan.squads
  #end
  
  #this works, don't delete, will probably be uses later...
  def list_squads_xhr
    page.replace_html 'squads', :partial => 'squads', :locals => {:@squads => squads}
  end
  
  def list_site_members
      clan = Clan.find_for_site :first
      #page.replace_html 'members', :partial => 'members', :locals => {:@members => members}
      clan.members 
  end
  
  #defined in rights_mgmt_helper
  #def list_members
  #  
  #end
  
  #def list_squad_members squad
  #  squad.nil? ? [] : squad.members
  #end
  
  
end
