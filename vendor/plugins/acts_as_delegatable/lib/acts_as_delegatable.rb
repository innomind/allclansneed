# ActsAsDelegatable
module ActiveRecord
  module Acts; end
end;

module ActiveRecord::Acts::ActsAsDelegatable
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    def acts_as_site options = {}
      
      #def self.human_name(options = {})
      #  I18n.translate(self.name.underscore, :scope => [:activerecord, :models], :count => 1, :default => self.name.humanize)
      #end
              
      @options = options

      def self.find *args
        with_scope(:find => { :conditions => "site_id = #{$site_id}" }) do
          r = super(*args)
          if r.nil?
            with_exclusive_scope(:find => {  }) do
              unless super(*args).nil?
                raise ActiveRecord::RecordNotFound
              end
            end
          end
          r
        end
      end
      
      def self.new *args
        model = super(*args)
        model.site_id = $site_id
        model.user_id = $user_id if model.has_attribute?("user_id")
        model
      end
      
      def self.paginate *args
        super(*initilize_paginate(args))
      end
      
      def self.pages *args
        paginate(*initilize_paginate(args))
      end
      
      #could be refactored - but also could not
      def initilize_paginate args
        options = args.detect { |argument| argument.is_a?(Hash) }
        if options.nil?
          options = {:page => $page,
                     :per_page => 15,
                     :order => 'created_at DESC' 
          }
          args << options
        else
          options[:page] ||= $page 
          options[:per_page] ||= 2
          options[:order] ||= 'created_at DESC'
        end
        append_condition(args)
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
    
    def acts_as_delegatable
      include ActiveRecord::Acts::ActsAsDelegatable::InstanceMethods

      def self.method_missing method, *args
        with_scope(:find => { :conditions => "site_id = #{$site_id}" }, :create => { :site_id => $site_id }) do
          if find = method.to_s.match(/^find_for_site_(\w*)$/)
            self.send "find_#{find[1]}", *args
            #self.send "find_#{find[1]}".to_sym, *append_condition(args)
          elsif find = method.to_s.match(/^page_for_site_(\w*)$/)
            self.send "paginate_#{find[1]}".to_sym, *initilize_paginate(args)
          else
            super
          end
        end
      end
      
      def self.find_for_site *args
        with_scope(:find => { :conditions => "site_id = #{$site_id}" }, :create => { :site_id => $site_id }) do
          find(*args)
        end
      end
      
      def self.page_for_site *args
        with_scope(:find => { :conditions => "site_id = #{$site_id}" }, :create => { :site_id => $site_id }) do
          paginate(*initilize_paginate(args))
        end
      end
      
      private
      
      def do_find method, args
        old_args = args.dup
        #begin
          self.send method.to_sym, *append_condition(args)
       #rescue ActiveRecord::RecordNotFound
       #  raise "ACNException"
       #  if find(*old_args)
       #    raise "IntrusionException"
       #  end
       #end
      end
      
      def initilize_paginate args
        options = args.detect { |argument| argument.is_a?(Hash) }
        if options.nil?
          options = {:page => $page,
                     :per_page => 15,
                     :order => 'created_at DESC' 
          }
          args << options
        else
          options[:page] ||= $page 
          options[:per_page] ||= 15
          options[:order] ||= 'created_at DESC'
        end
        append_condition(args)
      end
      
      
      def initilize_paginate_new args
        options = args.detect { |argument| argument.is_a?(Hash) }
        if options.nil?
          {:page => $page,
                         :per_page => 15,
                         :order => 'created_at DESC' 
                       }
        else
          options.merge({:page => $page,
                         :per_page => 15,
                         :order => 'created_at DESC' 
                       })
          
        end
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
