class Squad < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :clan
  has_many :squad_users
  has_many :clanwars
  has_many :users, :through => :squad_users
  
  validates_length_of :name, 
      :within => 3..40, 
      :too_short => 'Name ist zu kurz, bitte mindestens %d Buchstaben verwenden',
      :too_long => 'Der Squadname darf nicht mehr als %d Buchstaben haben'
  
  def members
    users
  end
  
  
  #TODO: make this a real _transaction_, if something goes wrong, revert it (like migration up/down)
  def self.transfer_user user, src_squad, dst_squad
    user.squads.push dst_squad
    user.squads.delete src_squad
    user.save
  end
end
