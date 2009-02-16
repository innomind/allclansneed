class Poll < ActiveRecord::Base
  
  acts_as_delegatable
  
  belongs_to :site
  belongs_to :user
  
  has_many :poll_options, :dependent => :destroy
  has_many :pollresults, :dependent => :destroy
  
  after_update :save_options
  
  def polloption_attributes=(polloption_attributes)
    polloption_attributes.each do |attributes|
      if attributes[:id].blank?
        poll_options.build(attributes)
      else
        option = poll_options.detect { |op| op.id == attributes[:id].to_i }
        option.attributes = attributes
      end
    end
  end
  
  def save_options
    poll_options.each do |option|
      if option.should_destroy?
        option.destroy
      else
        option.save(false)
      end
    end
  end
end
