# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #some stuff for tag-clouding :)
  include TagsHelper
  
  def error_handling_form_for(record_or_name_or_array, *args, &proc)
    form_for(record_or_name_or_array, *append_builder(args), &proc)
  end
  
  def error_handling_remote_form_for(record_or_name_or_array, *args, &proc)
    remote_form_for(record_or_name_or_array, *append_builder(args), &proc)
  end
  
  def append_builder (args)
    options = args.detect { |argument| argument.is_a?(Hash) }
    if options.nil?
      options = {:builder => ErrorHandlingFormBuilder}
      args << options
    end 
    options[:builder] = ErrorHandlingFormBuilder unless options.nil?
    args
  end
  
  def username(user)
    link_to user.login, profile_path(user)
  end
  
  def entry_and_pagination model
    out = "<div>"
    out << will_paginate(model)
    out << "<div class='entries'>"
    out << page_entries_info(model)
    out << "</div>"
    out << "</div>"
  end
  
  def cloud(tags)
    return if tags.blank?
    output = ""
    mid = tags.first.count / 1.5
    tags.each do |t|
      size = 100 * t.count / mid
      size = 75 if size < 75
      output << link_to(t.name, { :action  => "findByTag",
                                  :id  => t.name},
                                  :style => "font-size: #{size}%") << " "
    end
    return output
  end
  
  def nl2br(text)
    text.gsub!(/\n/, '<br />')
  end
  
  def render_reply_text(text)
    str = ''
    text.each_line do |s|
      str << '>'+s
    end
    str
  end

  def show_verbose_messages
    str = ''
    until (obj = session['error_objects'].pop).nil? 
      #TODO: the following line would be cleaner, but i only want the specific error string
      #str << (error_messages_for obj.class.to_s.downcase, :object => obj)
      
      obj.errors.each {|i,j| j.each {|e| str << e}} #(error_messages_for obj.class, :object => obj)
    end
    str
  end
  
  #building popup calendar
  def calendar_for(field_id)
    include_calendar_headers_tags
    image_tag("calendar.png", {:id => "#{field_id}_trigger",:class => "calendar-trigger"}) +
    javascript_tag("Calendar.setup({inputField : '#{field_id}', ifFormat : '%Y-%m-%d', button : '#{field_id}_trigger' });")
  end
  
  def include_calendar_headers_tags
    content_for :header_tags do
      javascript_include_tag('calendar/calendar.js') +
      javascript_include_tag("calendar/lang/calendar-de.js") +
      javascript_include_tag('calendar/calendar-setup.js') +
      stylesheet_link_tag('calendar')
    end
  end
  
  #Hilfe texte
  def help_text(name=nil, opts={}, &proc)
    tooltip name, opts, &proc
  end
  
  def ajax_tooltip(name=nil, opts={})
    opts[:show_mode] = "ajax"
    tooltip name, opts
  end
  
  def ajax_tooltip_if(condition, name=nil, opts={}, &proc)
    if condition
      opts[:show_mode] = "ajax" 
    else
      opts[:show_mode] = "mouseover"
    end
    tooltip name, opts, &proc if opts[:text] = opts.delete(:alternate_text)
  end
  
  def ajax_loading_tag
    image_tag("loading.gif")
  end
  
  def show_breadcrumb(seperator='>')
    output = ""
    if @breadcrumbs
	  	@breadcrumbs[0..-2].each do |txt, path|  
	  	  output << link_to(h(txt), path)
	  	  output << " " + seperator + " "  
	  	end
	  	output << @breadcrumbs.last.first 
	  end
  end
  
  def intern_pic(model)
    if model.intern
      tooltip image_tag("key.png"), :show_mode => "mouseover", :text => "Intern"
    end
  end
end