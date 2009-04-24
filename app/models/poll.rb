class Poll < ActiveRecord::Base
  
  acts_as_site
  
  belongs_to :site
  belongs_to :user
  
  has_many :poll_options, :dependent => :destroy
  has_many :poll_results, :dependent => :destroy
  
  after_update :save_options
  has_many :comments, :as => :commentable, :dependent => :destroy  
  
  validates_associated :poll_options
  validates_presence_of :title
  
  def before_update
    p = Poll.find(id, :include => :comments)
    if p.intern != intern
      p.comments.each do |c| 
        c.intern = intern
        c.save
      end
    end
  end
  
  def close?
    !open
  end
  
  def status
    open? ? "offen" : "geschlossen"
  end
  
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
  
  def has_voted? user
    return false if user.nil?
    !self.poll_results.find_by_user_id(user.id).nil?
  end

  def self.box_poll user
    @polls = self.find(:all)
    return @polls.first if user.nil?
    @polls.each do |poll|
      return poll unless poll.has_voted? user
    end
    return nil
  end
end
