namespace :init do
  
  task :redo => :environment do
    sh "rake db:drop:all"
    sh "rake db:create:all"
    sh "rake db:migrate"
    sh "rake init:site"
    2.upto(5) { |i| sh "rake init:one_site site_id=#{i}" }
  end
  
  desc "Populates for site_id(1): template, template_areas, template_boxes, template_box_types, navigation_template, navigation"
  task :site => :environment do
    site = Site.find_by_id 1
    site.template = Template.create(:name => "DNP", :internal_name => "dnp")
    
    t_area = Hash.new
    t_area[:topnav] = TemplateArea.create(:name => "topnav", 
                                        :internal_name => "topnav", 
                                        :position => 1, 
                                        :multiple_boxes_allowed => false)
                                        
    t_area[:linke_seite] = TemplateArea.create(:name => "linke Seite", 
                                            :internal_name => "linke_seite", 
                                            :position => 2)
                                            
    t_area[:rechte_seite] = TemplateArea.create(:name => "rechte Seite", 
                                              :internal_name => "rechte_seite", 
                                              :position => 3)
                                              
    site.template.template_areas = t_area.values
    site.save
    Nav = Hash.new
    ["News", "Forum", "Event", "Gallery", "Clanwar", "Poll", "Guestbook", "Articles"].each {|n|
      tpl = NavigationTemplate.create(:name => n, :controller => n, :action => "index")
      Nav[n.to_s] = Navigation.create(:name => n, :navigation_template => tpl)
    }

    #Navi1
    tb = TemplateBox.create(:name => "topNavi", :position => 1)
    
    navBoxType = TemplateBoxType.create(:name => "Navigation", 
                                                  :internal_name => "navigation", 
                                                  :editable => true, 
                                                  :multiple_allowed => true)
    
    tb.template_box_type = navBoxType
                                                  
    tb.navigations << Nav["News"]
    tb.navigations << Nav["Forum"]
    tb.navigations << Nav["Event"]
    tb.navigations << Nav["Gallery"]
    tb.navigations << Nav["Articles"]
    
    tb.site = site
    t_area[:topnav].template_boxes << tb
    tb.save
    
    #Navi2
    tb = TemplateBox.create(:name => "ClanNavi", :position => 1)
    
    tb.template_box_type = navBoxType
                                                  
    tb.navigations << Nav["Clanwar"]
    tb.navigations << Nav["Poll"]
    tb.navigations << Nav["Guestbook"]
       
    tb.site = site
    t_area[:linke_seite].template_boxes << tb
    tb.save
    
    #Login
    tb = TemplateBox.create(:name => "login", :position => 1)
    tb.template_box_type = TemplateBoxType.create(:name => "Login", 
                                                  :internal_name => "login", 
                                                  :editable => false)
                                                  
    tb.site = site
    t_area[:rechte_seite].template_boxes << tb
    
    #Forum
    tb = TemplateBox.create(:name => "forum", :position => 2)
    tb.template_box_type = TemplateBoxType.create(:name => "Forum", 
                                                  :internal_name => "forum", 
                                                  :editable => true)
    tb.site = site
    t_area[:linke_seite].template_boxes << tb

    #Poll
    tb = TemplateBox.create(:name => "Aktuelle Polls", :position => 2)
    tb.template_box_type = TemplateBoxType.create(:name => "Poll",
                                                  :internal_name => "poll",
                                                  :editable => true)
    tb.site = site
    t_area[:linke_seite].template_boxes << tb

    #Random_Gallery_Pic
    tb = TemplateBox.create(:name => "Zufälliges Galeriebild", :position => 3)
    tb.template_box_type = TemplateBoxType.create(:name => "Zufäliges Galeriebild",
                                                  :internal_name => "gallery_pic",
                                                  :editable => true)
    tb.site = site
    t_area[:linke_seite].template_boxes << tb

    #Clanwars
    tb = TemplateBox.create(:name => "Letzte Clanwars", :position => 4)
    tb.template_box_type = TemplateBoxType.create(:name => "Letzte Clanwars",
                                                  :internal_name => "clanwar",
                                                  :editable => true)
    tb.site = site
    t_area[:linke_seite].template_boxes << tb

    #Calendar
    tb = TemplateBox.create(:name => "Kalender", :position => 5)
    tb.template_box_type = TemplateBoxType.create(:name => "Kalender",
                                                  :internal_name => "calendar",
                                                  :editable => true)
    tb.site = site
    t_area[:linke_seite].template_boxes << tb

    #Shoutbox
    tb = TemplateBox.create(:name => "Shoutbox", :position => 5)
    tb.template_box_type = TemplateBoxType.create(:name => "Shoutbox",
                                                  :internal_name => "shoutbox",
                                                  :editable => true)
    tb.site = site
    t_area[:linke_seite].template_boxes << tb
    
    tb.save
  end
  
  task :one_site => :environment do
    site = Site.find_by_id ENV['site_id']
    site.template = Template.find_by_internal_name "dnp"
    site.save
    
    t_area = Hash.new
    t_area[:topnav] = TemplateArea.find_by_name "topnav"
    t_area[:linke_seite] = TemplateArea.find_by_name "linke Seite"
    t_area[:rechte_seite] = TemplateArea.find_by_name "rechte Seite"
                                            
    Nav = Hash.new
    ["News", "Forum", "Event", "Gallery", "Clanwar", "Poll", "Guestbook"].each {|n|
      tpl = NavigationTemplate.find_by_name n
      Nav[n.to_s] = Navigation.create(:name => n, :navigation_template => tpl)
    }

    #Navi1
    tb = TemplateBox.create(:name => "topNavi", :position => 1)
    
    navBoxType = TemplateBoxType.find_by_name "Navigation"
    
    tb.template_box_type = navBoxType
    
    tb.navigations << Nav["News"]
    tb.navigations << Nav["Forum"]
    tb.navigations << Nav["Event"]
    tb.navigations << Nav["Gallery"]
    
    tb.site = site
    t_area[:topnav].template_boxes << tb
    tb.save
    
    #Navi2
    tb = TemplateBox.create(:name => "ClanNavi", :position => 1)
    
    tb.template_box_type = navBoxType
                                                  
    tb.navigations << Nav["Clanwar"]
    tb.navigations << Nav["Poll"]
    tb.navigations << Nav["Guestbook"]
       
    tb.site = site
    t_area[:linke_seite].template_boxes << tb
    tb.save
    
    #Login
    tb = TemplateBox.create(:name => "login", :position => 1)
    tb.template_box_type = TemplateBoxType.find_by_name "Login"
                                                      
    tb.site = site
    t_area[:rechte_seite].template_boxes << tb
    tb.save
    
    #Forum
    tb = TemplateBox.create(:name => "forum", :position => 2)
    tb.template_box_type = TemplateBoxType.find_by_name "Forum"
    tb.site = site
    t_area[:linke_seite].template_boxes << tb
    tb.save
  end
end