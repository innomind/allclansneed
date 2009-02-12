namespace :init do
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
    ["News", "Forum", "Event", "Gallery", "Clanwar", "Poll", "Guestbook"].each {|n|
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
    tb.save
    
  end
end