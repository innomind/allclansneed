class Clanwar < ActiveRecord::Base
  
  acts_as_delegatable
  has_many :clanwarmaps
  has_many :comments, :as => :commentable
  belongs_to :squad
  belongs_to :site
  
  def before_save
    self[:score].nil? ? self[:score] = 0 : self[:score]
    self[:score] = self[:score]+1
  end
end
