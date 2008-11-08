module ProfileHelper
  def show_user user
    link_to user.login, :controller => "profile", :action => "index", :id => user.id
  end
end
