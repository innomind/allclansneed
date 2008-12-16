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

end
extend ACN
print "functions offered by acn: "
ACN.instance_methods.each {|m| print '['+m+'] '}
puts

