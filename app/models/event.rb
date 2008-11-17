class Event < ActiveRecord::Base
  acts_as_delegatable
  belongs_to :site

  def before_save
    self[:expire_at] = Time.parse(date + " " + time)  
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
  
  def date=(date)
    if time.nil?
      self.expire_at = Time.parse(date + " 00:00")
    else
      self.expire_at = Time.parse(date + " " + time)
    end
  end
  
  def time=(time)
    if date.nil?
      self.expire_at = Time.parse([Time.today.year, Time.today.month, Time.today.day].join("-") + " " + time)
    else
      self.expire_at = Time.parse(date + " " + time)
    end
  end
end