class DaemonTask < ActiveRecord::Base
  validates_presence_of :task
  validates_presence_of :domain
  validates_presence_of :scheduled_at
  
  def self.next_task
    DaemonTask.first(:conditions => ["processed_at IS NULL AND scheduled_at <= ?", Time.now], :order => "scheduled_at")
  end
  
  def process_task
    update_attribute(:scheduled_at, nil)
    task = Autodns.new task, domain
    @answer = task.request
    
    update_attribute(:response, @answer.elements["response/result/msg/code"].text)
    update_attribute(:processed_at, Time.now)
  end
end