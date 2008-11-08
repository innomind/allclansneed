module ClanManagementHelper
  def list_squads squads
      page.replace_html 'squads', :partial => 'squads', :locals => {:@squads => squads}
  end
  
  def list_members
      clan = Clan.find_for_site :first
      #page.replace_html 'members', :partial => 'members', :locals => {:@members => members}
      clan.members
  end
  
  
end
