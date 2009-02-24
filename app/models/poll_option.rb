class PollOption < ActiveRecord::Base
  
  belongs_to :poll
  has_many :poll_results
  
  attr_accessor :should_destroy
  
  def should_destroy?
    should_destroy.to_i == 1
  end
end
