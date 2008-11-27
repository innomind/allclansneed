module ProfileHelper
  def show_user user
    link_to user.login, :controller => "profile", :action => "show", :id => user.id
  end
end
