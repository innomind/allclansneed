class PollOption < ActiveRecord::Base
  
  belongs_to :poll
  has_many :pollresults
end
