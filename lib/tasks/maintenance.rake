namespace :maintenance do
  
  def init
    I18n.locale = :de
  end
  
  # Maintenance Tasks that will be executed monthly
  task :monthly => :environment do
    init
    report(:month)
  end
  
  # Maintenance Tasks that will be executed weekly
  task :weekly => :environment do
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
  task :hourly => :environment do
    init
  end

  def welcome_site_mailing
    Site.find(:all, :include => :owner, :conditions => ["created_at < ? and welcome_mailing = ? ", 2.day.ago, false]).each do |current_site|
      unless current_site.nil?
        puts "Sending welcome mail to ##{current_site.id} - #{current_site.owner.email}"
        Postoffice.deliver_welcome_site(current_site)
        current_site.update_attribute("welcome_mailing", true)
      end
    end
  end
  
  def report intervall
    time_past = eval("1.#{intervall}.ago")
    time_past_reference = eval("2.#{intervall}.ago")
    time_now = Time.now
    
    stat = Array.new
    stat << ["Aktive Mitglieder", User.find(:all, :conditions => ["last_activity_at > ?", time_past]).size, User.find(:all, :conditions => ["last_activity_at > ? AND last_activity_at < ?", time_past_reference, time_past]).size]
    [User, Clan, Site, Message, Friendship].each do |klass|
      count = klass.find(:all, :conditions => ["created_at > ?", time_past]).size
      count_reference = klass.find(:all, :conditions => ["created_at > ? AND created_at < ?", time_past_reference, time_past]).size
      count_all = klass.find(:all).size
      stat << [klass.human_name(:count => 2), count, count_reference, count_all]
    end
    [News, ForumThread, ForumMessage, Poll, Clanwar, Page, Gallery, GalleryPic, Event].each do |klass|
      count = klass.find(:all, :global => true, :conditions => ["created_at > ?", time_past]).size
      count_reference = klass.find(:all, :global => true, :conditions => ["created_at > ? AND created_at < ?", time_past_reference, time_past]).size
      count_all = klass.find(:all, :global => true).size
      stat << [klass.human_name(:count => 2), count, count_reference, count_all]
    end
    Postoffice.deliver_reporting(stat, intervall)
  end

end