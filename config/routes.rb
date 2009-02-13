ActionController::Routing::Routes.draw do |map|
  #map.resources :squads

  #map.resources :clans

  
  #map.connect '', :pageid => 1, :controller => 'classified', :action => 'list'
  
  #map.connect ':page_id/:controller/:action/:id'
  
  #map.with_options(:controller => 'category') do |category|
  #  category.connect ':page_id/categories', :action => 'list'
  #  category.connect ':page_id/categories/show/:id', :action => 'show'
  #end

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #  admin.resources :guestbook
  #end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing the them or commenting them out if you're using named routes and resources.
  map.root :controller => 'login'
  
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
