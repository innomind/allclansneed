ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'login'
  
  map.resources :news, :singular => "onenews"
  
  map.users 'register', :controller => 'login', :action => 'create'
  #map.login 'login', :controller => 'login', :action => 'login'
  map.squads ':site_id/create_squad', :controller => 'clan_management', :action => 'create_squad'
  map.rights ':site_id/rights_management', :controller => 'rights_management', :action => 'rights_management'
  
  #map.forum_message ':site_id/forum/thread/new_message/:id', :controller => 'forum_message', :action => "new" 
  #map.forum_message 'forum/thread/:id/new', :controller => 'forum_message', :action => "new" 
  #map.forum_thread ':site_id/forum/thread/:id', :controller => 'forum_thread', :action => "index" 
  #map.forum_category ':site_id/forum/:id', :controller => 'forum', :action => 'index'
  #map.forum_root ':site_id/forum', :controller => 'forum', :action => 'index'
  
  #map.connect ":site_id/:controller/:action/:id/page/:page"
  map.connect ":site_id/:controller/:action/page/:page"
  map.connect ':site_id/:controller/:action/:id'
  map.connect ':site_id/:controller/:action'
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
