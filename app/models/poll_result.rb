class PollResult < ActiveRecord::Base
  belongs_to :poll
  belongs_to :polloption
  belongs_to :user
end
