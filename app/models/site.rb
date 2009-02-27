class Site < ActiveRecord::Base
  has_many :guestbooks, :dependent => :destroy
  has_many :news_categories, :dependent => :destroy
  has_many :gallery_categories, :dependent => :destroy
  has_many :gallery_pics, :dependent => :destroy
  has_many :forums, :dependent => :destroy
  has_many :forum_threads, :dependent => :destroy
  has_many :forum_messages, :dependent => :destroy
  has_many :clanwars, :dependent => :destroy
  has_many :events, :dependent => :destroy
  has_many :polls, :dependent => :destroy
  has_many :classifieds, :dependent => :destroy
  
  belongs_to :template
  
  has_many :template_boxes, :dependent => :destroy
  has_many :template_areas, :through => :template_boxes, :dependent => :destroy
  
  has_many :user_rights, :dependent => :destroy
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
  
  def self.get_boxes_for intern_name, template_id
    area = TemplateArea.find :first, :conditions => {:internal_name => intern_name, :template_id => template_id},
                            :joins => [:template_boxes]
    #TemplateBox.find_for_site :all, 
     #             :conditions => { :template_area_id => area}, 
      #            :include => [:template_box_type],
       #           :order => "position ASC"
    area.template_boxes
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