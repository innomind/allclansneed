class PollResult < ActiveRecord::Base
  belongs_to :poll
  belongs_to :poll_option
  belongs_to :user
  
  def after_save
    poll_option.vote_count += 1
    poll_option.save
    
    poll_option.poll.vote_count += 1
    poll_option.poll.save
  end
end
