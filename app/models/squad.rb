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
  
  
  #TODO: make these transfers  real _transactions_, if something goes wrong, revert it (like migration up/down)
  #dryed a little
  
  def self.move_user user, src_squad, dst_squad
    return false unless (copy_user user, src_squad, dst_squad)
    user.squads.delete src_squad
    user.save
  end
  
  #ok we could just add the user to dst and ignore src, but this wouldn't be clean
  #perhaps it's more a philosophical question
  #anyway, it's safer doing it this more strict way
  def self.copy_user user, src_squad, dst_squad
    return false unless user.squads.include? src_squad
    return false if user.squads.include? dst_squad
    user.squads.push dst_squad
    user.save
  end

end
