def db_start
    ActiveRecord::Base.establish_connection
    reload!
end

def db_stop
    ActiveRecord::Base.connection.disconnect!
end
