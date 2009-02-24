ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'news'
  
  map.resources :news, :singular => "onenews"
  
  map.resources :forums, :controller => "forum", :shallow => true do |forum|
    forum.resources :forum_threads, :controller => "forum_thread", :shallow => true, :except => [:index], :as => "threads" do |thread|
      thread.resources :forum_messages, :controller => "forum_message", :shallow => true, :as => "messages"
    end
  end
  
  map.resources :galleries, :controller => "gallery", :shallow => true do |gallery|
    gallery.resources :pics, :controller => "gallery_pic"
  end
  
  map.resources :polls, :controller => "poll", :member => {:vote => :post, :open => :get, :close => :get}
  
  map.resources :guestbooks, :controller => "guestbook",
                            :except => [:new, :update, :edit],
                            :member => {:add_comment => :post}
  
  map.resources :profiles, :controller => "profile"
  
  map.users 'register', :controller => 'login', :action => 'create'
  #map.login 'login', :controller => 'login', :action => 'login'
  map.squads ':site_id/create_squad', :controller => 'clan_management', :action => 'create_squad'
  map.rights ':site_id/rights_management', :controller => 'rights_management', :action => 'rights_management'
  
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
