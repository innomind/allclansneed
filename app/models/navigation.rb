class Navigation < ActiveRecord::Base
  acts_as_site
  
  belongs_to :site
  belongs_to :template_box
  belongs_to :navigation_template
  has_one :page, :dependent => :nullify
  
  validates_presence_of :name
  validates_presence_of :navigation_template_id, :unless => :has_page, :message => "muss ausgewählt werden (Oder eine eigene Seite)"
  
  def validate_on_create
    if !self.page.nil? && !self.navigation_template.nil?
      errors.add("navigation_template_id", "kann nicht gleichzeitig mit eigener Seite ausgewählt werden!")
    end
  end
  
  def has_page
    !self.page.nil?
  end
  
  def page_id
  end
end
