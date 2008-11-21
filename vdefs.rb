def db_start
    ActiveRecord::Base.establish_connection
    reload!
end

def db_stop
    ActiveRecord::Base.connection.disconnect!
end

# haha, "meta"-programming
def get attr, model
    str = model.to_s.capitalize+".all.collect{|o| "
    attr.each {|a| str << " o."+a.to_s}
    str << '}'
    puts str
    #eval str
end