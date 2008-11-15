class Clanwar < ActiveRecord::Base
  
  acts_as_delegatable
  has_many :comments, :as => :commentable
  belongs_to :squad
  belongs_to :site

  belongs_to :user
  has_many :clanwar_maps
  
  validates_presence_of :opponent
  validates_presence_of :squad_id
  validates_presence_of :site_id
  validates_presence_of :user_id
  
  def before_save
    self[:score] = 0
  end
  
  def clanwarmap_attributes=(clanwarmap_attributes)
    clanwarmap_attributes.each do |attributes|
      clanwar_maps.build(attributes)
    end
  end
end
