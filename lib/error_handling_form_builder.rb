
class ErrorHandlingFormBuilder < ActionView::Helpers::FormBuilder
  
  helpers = field_helpers +
    %w(date_select datetime_select time_select collection_select) +
    %w(collection_select select country_select time_zone_select) -
    %w(label fields_for) 
    
  helpers.each do |name|
    define_method name do |field, *args|
      options = args.detect {|argument| argument.is_a?(Hash)} || {}
      build_shell(field, options) do
        super
      end
    end
  end
  
  def build_shell(field, options)
    partial = options[:style].nil? ? 'forms/field' : 'forms/' + options[:style]
    @template.capture do
      #debugger
      #translate = I18n.t(field.to_s, :default => {:name => nil, :desc => nil},
      #                               :scope => [:dbfields, @object.class.name.tableize])
      field_name = @object.class.human_attr_name(field.to_s) if @object.class.methods.include?("human_attr_name")
      field_name ||= field
      desc =  @object.class.human_attr_desc(field.to_s) if @object.class.methods.include?("human_attr_desc")
      desc ||= ""
      locals = {
        :element => yield,
        :label   => label(field, (options[:label] || field_name)),
        :desc    => desc,
        :post_text => options[:post_text]
      }
      if has_errors_on?(field)
        #flash[:notice].push error_message(field, options)
        locals.merge!(:error => error_message(field, options))
        @template.render :partial => partial + '_with_errors',
                         :locals  => locals
      else
        @template.render :partial => partial,
                         :locals  => locals
      end
    end
  end
  
  def error_message(field, options)
    if has_errors_on?(field)
      errors = object.errors.on(field)
      errors.is_a?(Array) ? errors.to_sentence : errors
    else
      ''
    end
  end
  
  def has_errors_on?(field)
    !(object.nil? || object.errors.on(field).blank?)
  end
end
