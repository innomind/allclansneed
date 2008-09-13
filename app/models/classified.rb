class Classified < ActiveRecord::Base
  belongs_to :category
  belongs_to :user
  
  validates_presence_of :title
  validates_presence_of :price
  validates_presence_of :location
  validates_presence_of :description
  validates_presence_of :email, :message => "es muss eine email adresse angegeben werden"
  validates_numericality_of :price
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
  #validates_uniqueness_of :title, :message => "titel darf nur einmal vorkommen", :scope => "page_id"
  
  protected
    def validate
        errors.add(:price, "should be a positive value") if price.nil? || price < 0.01
    end
end
