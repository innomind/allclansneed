class Poll < ActiveRecord::Base
  
  acts_as_delegatable
  
  belongs_to :site
  belongs_to :user
  
  has_many :polloptions
  has_many :pollresults
  
  def poll_attributes=
    
  end
  
  def save_options
    
  end
end
