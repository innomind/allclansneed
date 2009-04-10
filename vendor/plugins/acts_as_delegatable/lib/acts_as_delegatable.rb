# ActsAsDelegatable
module ActiveRecord
  module Acts; end
end;

module ActiveRecord::Acts::ActsAsDelegatable
  
  def self.included(base)
    base.extend(ClassMethods)
  end
  
  module ClassMethods
    
    def human_attr_desc(attr)
      translation = I18n.t("activerecord.attributes.#{self.name.underscore}.#{attr}_desc", :default => "")
      return I18n.t("activerecord.attributes.default.#{attr}_desc", :default => "") if translation.blank?
      translation
    end
    
    def human_attr_name(attr)
      translation = I18n.t("activerecord.attributes.#{self.name.underscore}.#{attr}", :default => "")  
      translation = I18n.t("activerecord.attributes.default.#{attr}", :default => "") if translation.empty?
      return self.human_attribute_name(attr) if translation.empty?
      translation
    end
    
    def validates_site_uniqueness_of(*attr_names)
      configuration = { :message => I18n.t("activerecord.errors.messages.taken") }
      configuration.update(attr_names.pop) if attr_names.last.is_a?(Hash)
      validates_each attr_names do |m, a, v| 
        if m.new_record?
          m.errors.add(a, configuration[:message]) if find(:all, :conditions => {:title => v}).size > 0
        else
          m.errors.add(a, configuration[:message]) if find(:all, :conditions => {:title => v}).size > 0 unless eval("m.class.find(m.id).#{a}") == v
        end
      end
    end

    
    def acts_as_site options = {}
      
      #def self.human_name(options = {})
      #  I18n.translate(self.name.underscore, :scope => [:activerecord, :models], :count => 1, :default => self.name.humanize)
      #end
             
      @options = options

      def self.find *args
        #debugger
        options = args.find{|a| a.is_a? Hash}
        options ||= Hash.new
        unless options.delete(:global)
          conditions =  { :site_id => $site_id }

          if self.column_names.include? ("intern")
            conditions.merge!({:intern => false}) unless $user_belongs_to_site
          end
          
          with_scope(:find => { :conditions => conditions }) do
            r = super(*args)
            if r.nil?
              raise ActiveRecord::RecordNotFound
              #with_exclusive_scope(:find => {  }) do
              #  unless super(*args).nil?
              #    raise ActiveRecord::RecordNotFound
              #  end
              #end
            end
            r
          end
        else
          super(*args)
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
          options[:per_page] ||= 15
          options[:order] ||= 'created_at DESC'
        end
        args
      end
    end
  end
    
  module InstanceMethods
    def get_page
      "pageid: "+self[:site_id].to_s
    end
  end

end
