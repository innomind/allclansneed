module GroupsHelper
  def show_group group
    link_to group.name, :controller => "groups", :action => "show", :id => group.id
  end
end
