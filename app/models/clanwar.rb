class Clanwar < ActiveRecord::Base
  
  acts_as_delegatable
  
  has_many :comments, :as => :commentable
  belongs_to :squad
  belongs_to :site
  belongs_to :user
  has_many :clanwar_maps
  
  after_update :save_maps
  
  validates_associated :clanwar_maps
  
  validates_presence_of :opponent
  validates_presence_of :squad_id
  validates_presence_of :site_id
  validates_presence_of :user_id
  
  def clanwarmap_attributes=(clanwarmap_attributes)
    clanwarmap_attributes.each do |attributes|
      if attributes[:id].blank?
        clanwar_maps.build(attributes)
      else
        map = clanwar_maps.detect { |m| m.id == attributes[:id].to_i }
        map.attributes = attributes
      end
    end
  end
  
  def save_maps
    clanwar_maps.each do |m|
      if m.should_destroy?
        m.destroy
      else
        m.save(false)
      end
    end
  end
end
