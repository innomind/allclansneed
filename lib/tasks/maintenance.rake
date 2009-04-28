namespace :maintenance do
  
  def init
    I18n.locale = :de
  end
  
  # Maintenance Tasks that will be executed monthly
  task :monthly do
    init
    report(:month)
  end
  
  # Maintenance Tasks that will be executed weekly
  task :weekly do
    init
    report(:week)
  end

  # Maintenance Tasks that will be executed daily
  task :daily => :environment do
    init
    report(:day)
    welcome_site_mailing
  end
  
  # Maintenance Tasks that will be executed hourly
  task :hourly do
    init
  end

  def welcome_site_mailing
    Site.find(:all, :include => :owner, :conditions => ["created_at < ? and welcome_mailing = ? ", 2.day.ago, false]).each do |site|
      unless site.nil?
        Postoffice.deliver_welcome_site(site)
        site.update_attribute("welcome_mailing", true)
      end
    end
  end
  
  def report intervall
    time_past = eval("1.#{intervall}.ago")
    time_past_reference = eval("2.#{intervall}.ago")
    time_now = Time.now
    
    stat = Array.new
    [User, Clan, Site].each do |klass|
      count = klass.find(:all, :conditions => ["created_at > ?", time_past]).size
      count_reference = klass.find(:all, :conditions => ["created_at > ? AND created_at < ?", time_past_reference, time_past]).size
      stat << [klass.human_name, count, count_reference]
    end
    puts stat.inspect
  end

end