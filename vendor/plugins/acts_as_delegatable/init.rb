# Include hook code here
require 'acts_as_delegatable'
ActiveRecord::Base.send(:include, ActiveRecord::Acts::ActsAsDelegatable)
