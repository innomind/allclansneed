class Site < ActiveRecord::Base
  has_many :guestbooks, :dependent => :destroy
  has_many :categories, :dependent => :destroy
  has_many :gallery_pics, :dependent => :destroy
  has_many :forums, :dependent => :destroy
  has_many :forum_threads, :dependent => :destroy
  has_many :forum_messages, :dependent => :destroy
  has_many :clanwars, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :polls, :dependent => :destroy
  has_many :classifieds, :dependent => :destroy
  has_many :navigations, :dependent => :destroy
  
  belongs_to :template
  
  has_many :template_boxes, :dependent => :destroy
  has_many :template_areas, :through => :template_boxes #TODO check if this doesnt destroy the areas: , :dependent => :destroy
  
  belongs_to :owner, :class_name => "User", :foreign_key => "owner_id"
  has_many :user_rights, :dependent => :destroy
  has_many :users, :through => :user_rights
  has_one :clan
  
  #validates_uniqueness_of :title
  
  PORTAL_ID = 1
  PORTAL_NAME = "A * C * N - Portalseite"
  
  def after_create
    owner.sites << self
    
    self.categories << Category.create(:name => "Allgemein", :controller => "News")
    self.categories << Category.create(:name => "Clan", :controller => "News")
    self.categories << Category.create(:name => "Intern", :controller => "News", :intern => true)
    
    self.forums << Forum.create(:title => "Hauptforum")
    self.forums << Forum.create(:title => "Intern", :intern => true)
    
    create_boxes_for "dnp"
  end
  
  def is_portal?
    (id == PORTAL_ID)
  end
  
  def portal_name
    PORTAL_NAME
  end
  
  def self.get_boxes_for intern_name, template_id
    area = TemplateArea.find :first, :conditions => {:internal_name => intern_name, :template_id => template_id},
                            :joins => [:template_boxes]
    area.template_boxes
  end
  
  private
  
  def create_boxes_for tpl
    self.template = Template.find_by_internal_name tpl
    self.save
    
    t_area = Hash.new
    t_area[:topnav] = TemplateArea.find_by_name "topnav"
    t_area[:linke_seite] = TemplateArea.find_by_name "linke Seite"
    t_area[:rechte_seite] = TemplateArea.find_by_name "rechte Seite"
                                            
    nav = Hash.new
    ["News", "Forum", "User", "Kalender", "Galerie", "Clanwars", "Poll", "Gästebuch", "Articles"].each {|n|
      tpl = NavigationTemplate.find_by_name n
      nav[n.to_s] = Navigation.create(:name => n, :navigation_template => tpl)
      nav[n.to_s].site = self
      nav[n.to_s].save
    }

    #Navi1
    tb = TemplateBox.create(:name => "topNavi", :position => 1)
    
    navBoxType = TemplateBoxType.find_by_name "Navigation"
    
    tb.template_box_type = navBoxType
    
    tb.navigations << nav["News"]
    tb.navigations << nav["Forum"]
    tb.navigations << nav["Kalender"]
    tb.navigations << nav["Galerie"]
    
    tb.site = self
    t_area[:topnav].template_boxes << tb
    tb.save
    
    #Navi2
    tb = TemplateBox.create(:name => "ClanNavi", :position => 1)
    
    tb.template_box_type = navBoxType 
    tb.navigations << nav["User"]                                               
    tb.navigations << nav["Clanwars"]
    tb.navigations << nav["Poll"]
    tb.navigations << nav["Gästebuch"]
    tb.site = self
    t_area[:linke_seite].template_boxes << tb
    tb.save
    
    #Login
    tb = TemplateBox.create(:name => "Login", :position => 1)
    tb.template_box_type = TemplateBoxType.find_by_name "Login"
    tb.site = self
    t_area[:rechte_seite].template_boxes << tb
    tb.save
    
    #Forum
    tb = TemplateBox.create(:name => "Forum", :position => 2)
    tb.template_box_type = TemplateBoxType.find_by_name "Forum"
    tb.site = self
    t_area[:linke_seite].template_boxes << tb
    tb.save
    
    #Poll
    tb = TemplateBox.create(:name => "Poll", :position => 3)
    tb.template_box_type = TemplateBoxType.find_by_name "Poll"
    tb.site = self
    t_area[:linke_seite].template_boxes << tb
    tb.save
    
    #Galerie
    tb = TemplateBox.create(:name => "Zufalls Bild", :position => 4)
    tb.template_box_type = TemplateBoxType.find_by_name "Galerie"
    tb.site = self
    t_area[:linke_seite].template_boxes << tb
    tb.save
    
    #Login
    tb = TemplateBox.create(:name => "Kalender", :position => 2)
    tb.template_box_type = TemplateBoxType.find_by_name "Kalender"
    tb.site = self
    t_area[:rechte_seite].template_boxes << tb
    tb.save
    
    #Login
    tb = TemplateBox.create(:name => "Shoutbox", :position => 3)
    tb.template_box_type = TemplateBoxType.find_by_name "Shoutbox"
    tb.site = self
    t_area[:rechte_seite].template_boxes << tb
    tb.save
  end
end