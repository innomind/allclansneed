namespace :maintenance do
  
  def init
    I18n.locale = :de
  end
  
  # Maintenance Tasks that will be executed monthly
  task :monthly do
    init
    report(:monthly)
  end
  
  # Maintenance Tasks that will be executed weekly
  task :weekly do
    init
    report(:weekly)
  end

  # Maintenance Tasks that will be executed daily
  task :daily => :environment do
    init
    report(:daily)
    welcome_site_mailing
  end
  
  # Maintenance Tasks that will be executed hourly
  task :hourly do
    init
  end

  def welcome_site_mailing
    Site.find(:all, :include => :owner, :conditions => ["created_at < ? and welcome_mailing = ? ", 2.day.ago, false]).each do |site|
      Postoffice.deliver_welcome_site(site)
      site.update_attribute("welcome_mailing", true)
    end
  end
  
  def report intervall
    
  end

end