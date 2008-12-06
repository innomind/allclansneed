module RightsManagementHelper
  def list_components
    @user.nil? ? Component.all : Component.all.reject{|c| @user.components.include? c}
  end
  
  
  def list_members
    #current_site.members
  end
  
  #def components_for user
  #  user.components
  #end
  
end
