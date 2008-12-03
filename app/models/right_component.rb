class RightComponent < ActiveRecord::Base
  belongs_to :user_right
  belongs_to :component
end
