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

      def self.method_missing method, *args
        if find = method.to_s.match(/^find_for_site_(\w*)$/)
          self.send "find_#{find[1]}".to_sym, *append_condition(args)
        elsif find = method.to_s.match(/^page_for_site_(\w*)$/)
          self.send "paginate_#{find[1]}".to_sym, initilize_paginate(args)
        else
          super
        end
      end
      
      def self.find_for_site *args
        new_args = append_condition(args)
        find(*new_args)
      end
      
      def self.page_for_site *args
        paginate(*initilize_paginate(args))
      end
      
      private
      
      #TODO
      def initilize_paginate args
        debugger
        if args.count == 0
          new_args = Array.new
          new_args[0] = Hash.new
        end
        new_args[0][:page] ||= $page
        new_args[0][:per_page] ||= 10
        new_args[0][:order] ||= 'created_at DESC'
        append_condition(new_args)
      end
      
      def append_condition args, condition = nil
        condition ||= Hash.new(:site_id => $site_id)
        created = false
        new_args = args
        new_args.each do |a|
          if a.is_a?(Hash)
            a[:conditions] ||= Hash.new
            a[:conditions][:site_id] = $site_id if a[:conditions].is_a?(Hash)
            if a[:conditions].is_a?(Array)
              a[:conditions][0] = a[:conditions][0] + " AND site_id = ?"
              a[:conditions].push $site_id
            end
            created = true
          end
        end
        unless created
          new_args.push :conditions => {:site_id => $site_id }
        end
        new_args
      end
      
    end

  end
    
  module InstanceMethods
    def get_page
      "pageid: "+self[:site_id].to_s
    end

  end

end
