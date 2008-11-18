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

      
      def self.find_for_site *args
        #new_args.push :conditions => {:site_id => $site_id }
        new_args = append_condition(args)
        find(*new_args)
      end
      
      #ToDo
      def self.paginate_for_site *args
        if args.count == 0
          args = Array.new
          args[0] = Hash.new
        end
        args[0][:page] ||= $page
        args[0][:per_page] ||= 2
        args[0][:order] ||= 'created_at DESC'
        new_args = append_condition(args)
        paginate(*new_args)
      end
      
      private
      def append_condition args
        created = false
        new_args = args
        new_args.each do |a|
          if a.is_a?(Hash)
            if a[:conditions].nil?
              a[:conditions] = Hash.new
            end
            a[:conditions][:site_id] = $site_id
            created = true
          end
        end
        unless created
          new_args.push :conditions => {:site_id => $site_id }
        end
        new_args
      end
      
      #def self.find(*args)
        #with_scope( :find => { :cond...}
       # new_args = args
       # new_args.push :conditions => {:site_id => site_id }
       # super(*args)
      #end
    end

  end
    
  module InstanceMethods
    def get_page
      "pageid: "+self[:site_id].to_s
    end

  end

end
