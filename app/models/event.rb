class Event < ActiveRecord::Base
  acts_as_site
  belongs_to :site

  #before saving the event, expire_at must be build together
  def before_save
    self[:expire_at] = Time.parse(date + " " + time)  
  end
  
  def before_update
    e = Event.find(id, :include => :comments)
    if e.intern != intern
      e.comments.each do |c| 
        c.intern = intern
        c.save
      end
    end
  end
  
  #getter for virtual attribute date
  def date
    if self[:expire_at].nil?
      nil
    else
      [self[:expire_at].year, self[:expire_at].month, self[:expire_at].day].join("-")
    end
  end
  
  #getter for virtual attribute time
  def time
    if self.expire_at.nil?
      nil
    else
      [self.expire_at.hour, self.expire_at.min].join(":")
    end
  end
  
  # setting the date-part to expire_at
  # if time is nil, it will be set to to 00:00
  def date=(date)
    if time.nil?
      self.expire_at = Time.parse(date + " 00:00").utc
    else
      self.expire_at = Time.parse(date + " " + time).utc
    end
  end
  
  #setting the time-part to expire_at
  # if date is nil, it will be set to "today"
  def time=(time)
    if date.nil?
      self.expire_at = Time.parse([Time.today.year, Time.today.month, Time.today.day].join("-") + " " + time).utc
    else
      self.expire_at = Time.parse(date + " " + time).utc
    end
  end
end