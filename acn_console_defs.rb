module ACN
  def db_start
      ActiveRecord::Base.establish_connection
      reload!
  end
  
  def db_stop
      ActiveRecord::Base.connection.disconnect!
  end
  
  # usage: get_all [:attr1, :attr2...], :model <- double_names with undescore-notation
  def get_all attr, model
      str = model.to_s.split('_').collect{|part| part.capitalize}.join
      str << ".all.collect{|o| [] "
      #str[0,1] = str[0,1].capitalize # :( ugly
      attr.each {|a| str << " << o."+a.to_s}
      str << '}'
      #puts str
      eval str
  end

  #args self explaining...
  #returns member-variables to be set in addition
  #to an array of users: @u0, @u1, @u2 so that you
  #can work more quickly/easily on a specific usr
  def create_test_users count=5, should_save=false
    (0..count-1).inject([]){ |mem, num|
      usr = User.new(
        :nick => 'testnick'+num.to_s,
        :password => '123', 
        :email => "egal@host#{num.to_s}"
      )
      if should_save
          puts "error saving user #{usr.nick}" unless usr.save
      end
      eval("@u#{num} = usr")
      mem << usr
    }
  end
end

extend ACN
print "please remember: if you repeat yourself\n"
print "often in this shell, please add some code\n"
print "to \"acn_console_defs.rb\".\n"
print "functions offered by acn: "
ACN.instance_methods.each {|m| print '['+m+'] '}
puts

