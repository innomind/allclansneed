# ActsAsDelegatable
module ActiveRecord
  module Acts; end
end;



module ActiveRecord::Acts::ActsAsDelegatable
  
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def acts_as_delegatable
      include ActiveRecord::Acts::ActsAsDelegatable::InstanceMethods

      def self.find(*args)
        #with_scope( :find => { :cond...}
        new_args = args
        new_args.push :conditions => {:site_id => $session } #[:user].page_id}
          super(*args)
        #end
      end

    end
    
  end
    
  module InstanceMethods
      def get_page
        "pageid: "+self[:site_id].to_s
      end

  end
end
