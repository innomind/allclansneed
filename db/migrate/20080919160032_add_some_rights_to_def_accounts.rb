class AddSomeRightsToDefAccounts < ActiveRecord::Migration
  def self.up
    list = ['News/create', 'Guestbook/new', 'Forum/new_thread']
    i = -1
    puts 'migrmigr'
    Account.all.each do |acc|
      acc.right = list[i = i+1]
      acc.save
      if i > 2
          i = 0 
      end
    end
    
  end

  def self.down
    
  end
end
