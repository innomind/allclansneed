class SomeDefaultRightsInserts < ActiveRecord::Migration
  def self.up
    usr0 = User.new  :login  => "ben",
      :password  => "test",
      :email => "ben@test.de"
                
    usr1 = User.new  :login  => "tester",
      :password => "123",
      :email => "tester@test.de"
    
    usr2 = User.new  :login  => "philipp",
      :password => "test",
      :email => "pw@test.de"
    
    usr0.accounts.build(:site_id => 1)
    usr1.accounts.build(:site_id => 2)
    usr2.accounts.build(:site_id => 3)
    
    usr0.save
    usr1.save
    usr2.save
    
    
  end

  def self.down
  end
end
