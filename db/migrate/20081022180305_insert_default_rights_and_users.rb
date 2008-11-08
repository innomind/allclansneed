class InsertDefaultRightsAndUsers < ActiveRecord::Migration
  
  MAIN_TITLE="Mainpage"
  
  #FIXME: site_id of @main_site should be 1, this is not working for rake migrate:redo without SQL-HACK!
  
  def self.generate_users
    @users = [
      User.new(  :login  => "philipp",
        :password => "test",
        :email => "pw@allclansneed.de"
      ),
      User.new(  :login  => "ben",
        :password  => "test",
        :email => "ben@test.de"
      ),
      User.new(  :login  => "valentin",
        :password => "test",
        :email => "valentin.schulte@gmx.de"
      )
    ]    
  end
  
  def self.generate_sites
    @sites = []
    @main_site = Site.new(:title => MAIN_TITLE)
    #@main_site.id=1
    2.upto(@users.length+1) { |i|
      @sites.push Site.new(:title => "page #{i}", :id => i) 
    }
    
  end
  
  def self.up
    generate_users
    generate_sites

    @main_site.save
    @users.each do |usr|
      usr.user_rights.push UserRight.create(:user => usr, :site_id => 1, :level => 1)
      usr.user_rights.push UserRight.create(:user => usr, :site => @sites.pop, :level => 2)
      
      #FIXME: ok, i would say, this is an exaggeration of "ruby-feature" usage ;)
      # i promise, i will never use unnecessary lambdas again :)   
      raise "Something went wrong while saving user '#{usr.login}':\n"+
      lambda{err = String.new;usr.errors.each {|f,e| err << "#{f}: #{e}"};err}.call unless usr.save
    end
    #very ugly SQL-HACK
    execute "UPDATE sites SET id=1 WHERE title='#{MAIN_TITLE}'"
  end

  def self.down
    generate_users
    generate_sites
    
    @users.each do |usr|
      # not usr.delete() ! Because we have to kill the users by their unique names!
      User.destroy_all :login => usr.login
    end
      #same reason for sites...
    @sites.each do |site|
      Site.delete_all :title => site.title
    end
    Site.delete_all :title => @main_site.title
  end
end
