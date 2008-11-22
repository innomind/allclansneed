class Site < ActiveRecord::Base
  has_many :guestbooks
  has_many :news_categories
  has_many :gallery_categories
  has_many :gallery_pics
  has_many :forums
  has_many :forum_threads
  has_many :forum_messages
  has_many :clanwars
  has_many :events
  has_many :polls
  
  belongs_to :template
  
  has_many :template_boxes
  has_many :template_areas, :through => :template_boxes
  
  has_many :user_rights
  has_many :users, :through => :user_rights
  has_one :clan
  
  #validates_uniqueness_of :title
  
  PORTAL_ID = 1
  PORTAL_NAME = "A * C * N - Portalseite"
  
  def is_portal?
    (id == PORTAL_ID)
  end
  
  def portal_name
    PORTAL_NAME
  end

  #possibly slower / uglier alternatives for areas
  #areas = self.template.template_areas.select {|ta| ta.internal_name == ta_name.to_s}
  #areas = TemplateArea.find :all, :conditions => {:template_id => self.template_id, :internal_name => ta_name}
  
  def get_boxes ta_name
    areas = TemplateArea.all :conditions => {:internal_name => ta_name.to_s}
    TemplateBox.all :conditions => ["site_id = ? AND template_area_id IN (?)", self.id, areas]
  end
  
  def get_box_hash
    hash = {}
    def hash.[](ta)
      get_boxes ta
    end
    
    #mmmh, bad
    #def hash.each
    #end
    hash
  end
  
  # hey, this is fun :)
  #let's try another
  # KrAnK
  def getbs
    hash = {}
    areas = self.template.template_areas
    boxes = TemplateBox.all :conditions => ["site_id = ? AND template_area_id IN (?)", self.id, areas]
    areas.each {|a| hash[a.to_sym] = boxes[lambda{@i=0 if @i.nil?;@i+=1}.call]}
  end
  
end