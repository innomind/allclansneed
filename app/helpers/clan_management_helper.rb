module ClanManagementHelper
  def list_squads squads
      page.replace_html 'squads', :partial => 'squads', :locals => {:@squads => squads}
  end
  
  def list_members members
      page.replace_html 'members', :partial => 'members', :locals => {:@members => members}
  end
end
