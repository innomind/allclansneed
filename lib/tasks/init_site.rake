namespace :init do

  task :redo => :environment do
    sh "rake db:drop:all"
    sh "rake db:create:all"
    sh "rake db:migrate"
    #init
    puts "Init"
    #init
    init_components
    init_box_types
    init_navigations
    init_ticket_categories
    init_templates
    1.upto(4) { |i| puts "Create Site #{i}"; one_site i }
  end

  task :designes => :environment do
    unless Template.find_by_internal_name "d01"
      tpl = Template.create(:name => "d01", :internal_name => "d01", :page_text_1 => "oben rechts")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "rechte Seite", :internal_name => "rightside", :position => 1)
      tpl.save
    end

    #unless Template.find_by_internal_name "d03"
    #  tpl = Template.create(:name => "d03", :internal_name => "d03", :page_text_1 => "oben links", :page_text_2 => "oben rechts", :account_type => "bug")
    #  tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
    #  tpl.template_areas << TemplateArea.create(:name => "rechte Seite", :internal_name => "rightside", :position => 1)
    #  tpl.template_areas << TemplateArea.create(:name => "rechts alleine 1", :internal_name => "rightsingle1", :position => 2, :multiple_boxes_allowed => false)
    #  tpl.template_areas << TemplateArea.create(:name => "rechts alleine 2", :internal_name => "rightsingle2", :position => 3, :multiple_boxes_allowed => false)
    #  tpl.save
    #end

    unless Template.find_by_internal_name "d05"
      tpl = Template.create(:name => "d05", :internal_name => "d05", :page_text_1 => "oben links", :page_text_2 => "linke Leiste", :page_text_3 => "1. rechte Leiste", :page_text_4 => "2. rechte Leiste")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "1. rechte Seite", :internal_name => "rightside1", :position => 1)
      tpl.template_areas << TemplateArea.create(:name => "2. rechte Seite", :internal_name => "rightside2", :position => 2)
      tpl.save
    end

    unless Template.find_by_internal_name "d06"
      tpl = Template.create(:name => "d06", :internal_name => "d06", :page_text_1 => "Untertietel", :page_text_2 => "über Inhalt")
      tpl.template_areas << TemplateArea.create(:name => "Top Navigation", :internal_name => "top_nav", :position => 0,
                                                :multiple_boxes_allowed => false,
                                                :prefered_box_type_id => TemplateBoxType.find_by_name("Navigation").id,
                                                :max_list_items => 7)
      tpl.template_areas << TemplateArea.create(:name => "1. rechte Leiste", :internal_name => "rightside1", :position => 1)
      tpl.template_areas << TemplateArea.create(:name => "2. rechte Leiste", :internal_name => "rightside2", :position => 2)
      tpl.save
    end

    unless Template.find_by_internal_name "d07"
      tpl = Template.create(:name => "d07", :internal_name => "d07", :page_text_1 => "oben links", :page_text_2 => "Header mitte", :page_text_3 => "kleiner Titel")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "1. rechte Leiste", :internal_name => "rightside1", :position => 1)
      tpl.template_areas << TemplateArea.create(:name => "2. rechte Leiste", :internal_name => "rightside2", :position => 2)
      tpl.save
    end

    unless Template.find_by_internal_name "d09"
      tpl = Template.create(:name => "d09", :internal_name => "d09")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "rechte Seite", :internal_name => "rightside", :position => 1)
      tpl.save
    end

    unless Template.find_by_internal_name "d12"
      tpl = Template.create(:name => "d12", :internal_name => "d12", :page_text_1  => "oben mitte", :page_text_2 => "über dem Inhalt")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "1. rechte Seite", :internal_name => "rightside1", :position => 1)
      tpl.template_areas << TemplateArea.create(:name => "2. rechte Seite", :internal_name => "rightside2", :position => 2)
      tpl.save
    end

    unless Template.find_by_internal_name "d13"
      tpl = Template.create(:name => "d13", :internal_name => "d13", :page_text_1  => "oben links", :page_text_2 => "oben rechts", :page_text_2 => "über 2. rechte Leiste")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "1. rechte Seite", :internal_name => "rightside1", :position => 1)
      tpl.template_areas << TemplateArea.create(:name => "2. rechte Seite", :internal_name => "rightside2", :position => 2)
      tpl.save
    end

    unless Template.find_by_internal_name "d15"
      tpl = Template.create(:name => "d15", :internal_name => "d15", :account_type => "beta")
      tpl.template_areas << TemplateArea.create(:name => "linke Seite", :internal_name => "leftside", :position => 0)
      tpl.template_areas << TemplateArea.create(:name => "rechte Seite", :internal_name => "rightside", :position => 1)
      tpl.save
    end
  end

  def create_sites

  end

  def init_components
    Component.create(:name => "Artikel", :controller => "article")
    Component.create(:name => "Clanwar", :controller => "clanwar_map", :parent_id => Component.create(:name => "Clanwar", :controller => "clanwar").id)
    Component.create(:name => "Kalender", :controller => "event")
    forum = Component.create(:name => "Forum", :controller => "forum")
    Component.create(:name => "Forum Thread", :controller => "forum_thread", :parent_id => forum.id)
    Component.create(:name => "Forum Message", :controller => "forum_message", :parent_id => forum.id)
    gallery = Component.create(:name => "Galerie", :controller => "gallery")
    Component.create(:name => "Gallery Pic", :controller => "gallery_pic", :parent_id => gallery.id)
    Component.create(:name => "Gästebuch", :controller => "guestbook")
    Component.create(:name => "News", :controller => "news")
    Component.create(:name => "Poll", :controller => "poll")
    Component.create(:name => "Shoutbox", :controller => "shoutbox")
  end

  def init_navigations
    [["News", "news_path"], ["User", "profiles_path"], ["Forum", "forums_path"], ["Kalender", "events_path"], ["Galerie", "galleries_path"], ["Clanwars", "clanwars_path"], ["Poll", "polls_path"], ["Gästebuch", "guestbooks_path"], ["Artikel", "articles_path"]].each {|n|
      NavigationTemplate.create(:name => n[0], :link_path => n[1])
    }
  end

  def init_box_types
    TemplateBoxType.create(:name => "Login", :internal_name => "login", :editable => false)
    TemplateBoxType.create(:name => "Navigation", :internal_name => "navigation", :editable => true, :multiple_allowed => true, :edit_in_new_window => true, :link_list => true)
    TemplateBoxType.create(:name => "Forum", :internal_name => "forum")
    TemplateBoxType.create(:name => "Galerie", :internal_name => "gallery_pic")
    TemplateBoxType.create(:name => "Poll", :internal_name => "poll")
    TemplateBoxType.create(:name => "Clanwars", :internal_name => "clanwar")
    TemplateBoxType.create(:name => "Kalender", :internal_name => "calendar")
    TemplateBoxType.create(:name => "Shoutbox", :internal_name => "shoutbox")
  end

  def init_templates
    puts "template init"
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

    template = Template.create(:name => "portal", :internal_name => "portal", :account_type => "")
    template.template_areas << TemplateArea.create(:name => "rechte_leiste", :internal_name => "rechte_leiste")
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
      {:login  => "test1", :password => "test", :email => "test1@example.de"},
      {:login  => "test2", :password  => "test", :email => "test2@example.de"},
      {:login  => "test3", :password => "test",:email => "test3@example.de"},
      {:login => "test4", :password => "test", :email => "test4@example.de"}
    ]
  end

  def init
    init_components
    init_box_types
    init_navigations
    init_ticket_categories
    init_templates
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
