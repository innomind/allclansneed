namespace :init do
  
  task :redo => :environment do
    sh "rake db:drop:all"
    sh "rake db:create:all"
    sh "rake db:migrate"
    #init
    puts "Init"
    init
    1.upto(4) { |i| puts "Create Site #{i}"; one_site i }
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
    [["News", "news_path"], ["User", "profiles_path"], ["Forum", "forums_path"], ["Kalender", "events_path"], ["Galerie", "galleries_path"], ["Clanwars", "clanwars_path"], ["Poll", "polls_path"], ["Gästebuch", "guestbooks_path"], ["Articles", "articles_path"]].each {|n|
      NavigationTemplate.create(:name => n[0], :link_path => n[1])
    }
  end
  
  def init_box_types
    TemplateBoxType.create(:name => "Login", :internal_name => "login", :editable => false)
    TemplateBoxType.create(:name => "Navigation", :internal_name => "navigation", :editable => true, :multiple_allowed => true, :edit_in_new_window => true, :link_list => true)
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
                        :prefered_box_type_id => TemplateBoxType.find_by_name("Navigation").id,
                        :multiple_boxes_allowed => false)
    template.template_areas << TemplateArea.create(:name => "linke Seite", 
                        :internal_name => "linke_seite", 
                        :position => 2)
    template.template_areas << TemplateArea.create(:name => "rechte Seite", 
                        :internal_name => "rechte_seite", 
                        :position => 3)
                        
    template = Template.create(:name => "d08", :internal_name => "d08", :page_text_1 => "oben links", :page_text_2 => "oben rechts", :page_text_3 => "unten links", :page_text_4 => "unten rechts")
    template.template_areas << TemplateArea.create(:name => "links oben", 
                        :internal_name => "topleft", 
                        :position => 1, 
                        :multiple_boxes_allowed => false,
                        :prefered_box_type_id => TemplateBoxType.find_by_name("Navigation").id,
                        :max_list_items => 4)
    template.template_areas << TemplateArea.create(:name => "linke Seite", 
                        :internal_name => "leftside", 
                        :position => 2)
    template.template_areas << TemplateArea.create(:name => "rechte Seite", 
                        :internal_name => "rightside", 
                        :position => 3)
  end
  
  def init_ticket_categories
    Category.create(:name => "offen", :controller => "Ticket", :section => "status")
    Category.create(:name => "Fragen offen", :controller => "Ticket", :section => "status")
    Category.create(:name => "in Bearbeitung", :controller => "Ticket", :section => "status")
    Category.create(:name => "geschlossen", :controller => "Ticket", :section => "status")
    
    Category.create(:name => "Fehler", :controller => "Ticket")
    Category.create(:name => "Funktion gewünscht", :controller => "Ticket")
    Category.create(:name => "Feedback", :controller => "Ticket")
    Category.create(:name => "sonstiges", :controller => "Ticket")
    
    Category.all.each{|c| c.site_id = 1; c.save}
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
    init_ticket_categories
  end
  
  desc "Basic initial settings"
  task :site => :environment do
    init
  end
  
  def one_site id
    site_id = id
    user = User.create(dev_users[site_id-1])
    uniq = (site_id == 1 ? "portal" : "clan#{site_id}")
    clan = Clan.create(:name => uniq, :uniq => uniq, :owner_id => user.id)
    clan.save
    site = Site.create(:owner_id => user.id, :sub_domain => uniq)
    clan.site = site
    clan.save
  end
  
  task :one_site => :environment do
    one_site ENV['site_id'].to_i
  end
end