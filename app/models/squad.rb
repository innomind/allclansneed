class Squad < ActiveRecord::Base
  
  belongs_to :clan
  has_many :squad_users
  has_many :users, :through => :squad_users
  
  validates_length_of :name, 
      :within => 3..40, 
      :too_short => 'Name ist zu kurz, bitte mindestens %d Buchstaben verwenden',
      :too_long => 'Der Squadname darf nicht mehr als %d Buchstaben haben'
  
end
