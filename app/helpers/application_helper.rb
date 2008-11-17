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
  
  def template_boxes_for intern_name
    #area = TemplateArea.find(:all, :conditions => { :intern_name => intern_name})
  end
  
  #popup
  #def popup(partial, popup_space)
  def test123
    #@template.alert "hallo :-)"
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
      str << (error_messages_for obj)
    end
    str
  end
 
  def div_encapsulate string, id=nil
    "<div #{id.nil? ? "" : 'id="'+id.to_s+'"'}>"+string.to_s+'</div>'
  end
  
end