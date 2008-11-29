class InsertDeveloperRightsUsersClans < ActiveRecord::Migration
  
  #MAIN_TITLE="Mainpage"
  
  #FIXME: site_id of @main_site should be 1, this is not working for rake migrate:redo without SQL-HACK!
  
  def self.generate_users
    @users = User.acn_dev_users#::ACN_DEV_USERS
  end
  
  def self.generate_sites
    @sites = []
    @main_site = Site.new(:title => Site::PORTAL_NAME)
    #@main_site.id=1
    2.upto(@users.length+1) { |i|
      @sites.push Site.new(:title => "page #{i}", :id => i) 
    }
  end
  
  def self.generate_clans
    @clans = [] 
    1.upto(@users.length) { |i| 
      @clans.push Clan.new(:name => "Clan no #{i}")
    }
  end
  
  def self.up
    generate_users
    generate_sites
    generate_clans

    @main_site.save
    #every user gets main and other site
    @users.each do |usr|
      usr.user_rights.push UserRight.create(:user => usr, :site_id => 1, :right_type => 1)
      usr.user_rights.push UserRight.create(:user => usr, :site => @sites.pop, :right_type => 2)
      
      #FIXME: ok, i would say, this is an exaggeration of "ruby-feature" usage ;)
      # i promise, i will never use unnecessary lambdas again :)   
      raise "Something went wrong while saving user '#{usr.login}':\n"+
      lambda{err = String.new;usr.errors.each {|f,e| err << "#{f}: #{e}"};err}.call unless usr.save
    end
    
    #every site (except main site) gets a clan
    @sites = Site.all
    0.upto(@users.length-1) { |i| 
      raise "Something went wrong while saving clan '#{@clans[i].name}':\n"+
      lambda{err = String.new;@clans[i].errors.each {|f,e| err << "#{f}: #{e}"};err}.call unless @clans[i].save
      @sites[i+1].clan = @clans[i]
      #@sites[i].save
    }
    #very ugly SQL-HACK
    execute "UPDATE sites SET id=#{Site::PORTAL_ID} WHERE title='#{Site::PORTAL_NAME}'"
  end

  def self.down
    generate_users
    generate_sites
    generate_clans
    
    @users.each do |usr|
      # not usr.delete() ! Because we have to kill the users by their unique names!
      User.destroy_all :login => usr.login
    end
      #same reason for sites...
    @sites.each do |site|
      Site.delete_all :title => site.title
    end
    Site.delete_all :title => @main_site.title
    @clans.each do |clan|
      Clan.delete_all :name => clan.name
    end
  end
end
