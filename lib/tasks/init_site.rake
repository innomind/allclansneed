namespace :init do
  
  task :redo => :environment do
    sh "rake db:drop:all"
    sh "rake db:create:all"
    sh "rake db:migrate"
    #init
    sh "rake init:site"
    1.upto(4) { |i| sh "rake init:one_site site_id=#{i}" }
  end
  
  def create_sites
    
  end
  
  def init_components
    Component.create(:name => "Artikel", :controller => "artikel")
    Component.create(:name => "Clanwar", :controller => "clanwar_map", :parent_id => Component.create(:name => "Clanwar", :controller => "clanwar"))
    Component.create(:name => "Kalender", :controller => "event")
    forum = Component.create(:name => "Forum", :controller => "forum")
    Component.create(:name => "Forum Thread", :controller => "forum_thread", :parent_id => forum)
    Component.create(:name => "Forum Message", :controller => "forum_message", :parent_id => forum)
    gallery = Component.create(:name => "Galerie", :controller => "gallery")
    Component.create(:name => "Gallery Pic", :controller => "gallery_pic", :parent_id => gallery)
    Component.create(:name => "Gästebuch", :controller => "guestbook")
    Component.create(:name => "News", :controller => "news")
    Component.create(:name => "Poll", :controller => "poll")
    Component.create(:name => "Shoutbox", :controller => "shoutbox")
  end
  
  def init_navigations
    ["News", "Forum", "Event", "Gallery", "Clanwar", "Poll", "Guestbook", "Articles"].each {|n|
      NavigationTemplate.create(:name => n, :controller => n, :action => "index")
    }
  end
  
  def init_box_types
    TemplateBoxType.create(:name => "Login", :internal_name => "login", :editable => false)
    TemplateBoxType.create(:name => "Navigation", :internal_name => "navigation", :editable => true, :multiple_allowed => true)
    TemplateBoxType.create(:name => "Forum", :internal_name => "forum", :editable => true)
    TemplateBoxType.create(:name => "Galerie", :internal_name => "gallery_pic", :editable => true)
    TemplateBoxType.create(:name => "Poll", :internal_name => "poll", :editable => true)
    TemplateBoxType.create(:name => "Clanwars", :internal_name => "clanwar", :editable => true)
    TemplateBoxType.create(:name => "Kalender", :internal_name => "calendar", :editable => true)
    TemplateBoxType.create(:name => "Shoutbox", :internal_name => "shoutbox", :editable => true)
  end
  
  def init_template
    template = Template.create(:name => "DNP", :internal_name => "dnp")
    template.template_areas << TemplateArea.create(:name => "topnav", 
                        :internal_name => "topnav", 
                        :position => 1, 
                        :multiple_boxes_allowed => false)
    template.template_areas << TemplateArea.create(:name => "linke Seite", 
                        :internal_name => "linke_seite", 
                        :position => 2)
    template.template_areas << TemplateArea.create(:name => "rechte Seite", 
                        :internal_name => "rechte_seite", 
                        :position => 3)
  end
  
  def dev_users
    [
      {:login  => "philipp", :password => "test", :email => "pw@allclansneed.de"},
      {:login  => "ben", :password  => "test",    :email => "ben@test.de"},
      {:login  => "valentin", :password => "test",:email => "valentin.schulte@gmx.de"},
      {:login => "philippm", :password => "test", :email => "philippm@test.de"}
    ]
  end
  
  def init
    init_components
    init_box_types
    init_navigations
    init_template
  end
  
  desc "Basic initial settings"
  task :site => :environment do
    init
  end
  
  task :one_site => :environment do
    site_id = ENV['site_id'].to_i
    user = User.create(dev_users[site_id-1])
    uniq = (site_id == 1 ? "portal" : "clan#{site_id}")
    clan = Clan.create(:name => uniq, :uniq => uniq, :owner_id => user.id)
    clan.save
    site = Site.create(:owner_id => user.id, :subdomain => uniq)
    clan.site = site
    clan.save
  end
end