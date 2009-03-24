ActionController::Routing::Routes.draw do |map|
  map.resources :administration
  
  map.resources :tickets
  
  map.resources :ticket_messages, :controller => "TicketMessage"

  map.root :controller => 'news'
  
  map.resources :news, :singular => "onenews"
  
  map.resources :forums, :controller => "forum", :shallow => true do |forum|
    forum.resources :forum_threads, :controller => "forum_thread", :shallow => true, :as => "threads" do |thread|
      thread.resources :forum_messages, :controller => "forum_message", :shallow => true, :as => "posts"
    end
  end
  
  map.resources :galleries, :controller => "gallery", :shallow => true do |gallery|
    gallery.resources :pics, :controller => "gallery_pic"
  end
  
  map.resources :polls, :controller => "poll", :member => {:vote => :post, :open => :get, :close => :get}
  
  map.resources :guestbooks, :controller => "guestbook",
                            :except => [:new, :update, :edit],
                            :member => {:add_comment => :post}
  
  map.resources :profiles, :controller => "profile", :collection => {:start => :get}

  map.resources :articles, :controller => "article"
  
  map.resources :templates, :member => { :choose => :get }
  
  map.resources :boxes, :controller => "template_boxes", 
                                     :member => { :update_positions => :post,
                                     :move => :get,
                                     :do_move => :post }
  
  map.resources :navigations, :controller => "navigation",
                                     :collection => {:edit_box => :get,
                                                     :update_positions => :post},
                                     :member => {:move => :get,
                                                 :do_move => :post}
  
  map.resources :messages, :member => { :create => :post, :answer => :get }
  
  map.resources :messages

  map.resources :categories, :member => {:newcat => :get, :createcat => :post}, :except => :new,
                             :collection => {:update_positions => :post}
  
  map.resources :classifieds, :as => "kleinanzeigen"
  
  map.resources :friends, :only => [:show, :index, :destroy],
                          :member => [:accept, :reject, :become]

  map.resources :groups, :member => [:join, :administrate, :activate, :kick], :shallow => true do |group|
    group.resources :forum_threads, :controller => "forum_thread", :as => "threads" do |thread|
      thread.resources :forum_messages, :controller => "forum_message", :shallow => true, :as => "posts"
    end
  end

  map.resources :clanwars, :controller => "clanwar" do |clanwar|
    clanwar.resources :clanwar_screenshots, :controller => "clanwar_screenshot"
  end
  
  map.resources :events, :controller => "event", :collection => {:showDay => :get}

  map.resources :squads, :controller => 'squad', :member => {:confirm_users => :get, :confirm_users_save => :put}, :shallow => true do |squad|
    squad.resources :users, :controller => 'squad_user', :member => {:role => :get, :update_role => :put, :copy => :get, :do_copy => :post, :move => :get, :do_move => :post, :destroy_form => :get}
  end

  map.resources :clans, :member => {:leave => :delete} do |clan|
    clan.resource :site, :controller => "site", :only => [:new, :create]
    clan.resources :squads, :controller => "squad", :member => {:confirm_users => :get, :confirm_users_save => :put} do |squad|
      squad.resources :users, :controller => 'squad_user', :member => {:role => :get, :update_role => :put, :copy => :get, :do_copy => :post, :move => :get, :do_move => :post, :destroy_form => :get}
    end
  end
  
  map.resources :sites, :controller => "site", :only => [:update]

  map.resources :clan_join_inquiry

  #map.users 'register', :controller => 'login', :action => 'create'
  #map.login 'login', :controller => 'login', :action => 'login'
  #map.squads ':site_id/create_squad', :controller => 'clan_management', :action => 'create_squad'
  #map.rights ':site_id/rights_management', :controller => 'rights_management', :action => 'rights_management'
  
  map.connect ':controller/:action'
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
 
end
