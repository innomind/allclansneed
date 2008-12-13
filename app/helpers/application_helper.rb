# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #some stuff for tag-clouding :)
  include TagsHelper
  
  def error_handling_form_for(record_or_name_or_array, *args, &proc)
    options = args.detect { |argument| argument.is_a?(Hash) }
    if options.nil?
      options = {:builder => ErrorHandlingFormBuilder}
      args << options
    end 
    options[:builder] = ErrorHandlingFormBuilder unless options.nil?
    form_for(record_or_name_or_array, *args, &proc)
  end
  
  def get_boxes_for internal_name
    @template_areas.find{|a| a.internal_name == internal_name}.template_boxes
  end
  
  def create_box box
    render :partial => "boxes/#{box.template_box_type.internal_name}/show_loader", 
           :locals => {:box => box}
  end
  
  def username(user)
    link_to user.login, :controller => "profile", :action => "index", :id => user.id
  end
  
  #returns a formated date-string  
  def german_date_with_time(datum)     
    datum.strftime("%d.%m.%Y %H:%M")
  end
  
  def german_date(datum)     
    datum.strftime("%d.%m.%Y")
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
 
  #TODO: use the code2block wiki-entry!
  def div_encapsulate string, id=nil
    "<div #{id.nil? ? "" : 'id="'+id.to_s+'"'}>"+string.to_s+'</div>'
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
  def helper(name=nil, opts={}, &proc)
    tooltip name, opts, &proc
  end
  

end