class AddSomeDummyDateToDatabase < ActiveRecord::Migration
  def self.up
    #9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08
    #a665a45920422f9d417e4867efdc4fb8a04a1f3fff1fa07e998e86f7f7a27ae3
    
    Account.create  :nick  => "ben",
                    :password  => "test",
                    :email => "ben@test.de",
                    :site_id  => "1"
                    
    Account.create  :nick  => "tester",
                    :password => "123",
                    :email => "tester@test.de",
                    :site_id  => "2"
    
    Account.create  :nick  => "philipp",
                    :password => "test",
                    :email => "pw@test.de",
                    :site_id  => "3"
                    
    Site.create     :title => "erste page"
    Site.create     :title => "zweite page"     
    
    remove_column :news, :news_category_id  
  end

  def self.down
  end
end
