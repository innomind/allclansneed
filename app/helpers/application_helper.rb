# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #some stuff for tag-clouding :)
  include TagsHelper
  
  #popup
  def popup(partial, popup_space)
    page.alert "hallo :-)"
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
  
  def div_encapsulate string, id=nil
    "<div #{id.nil? ? "" : id.to_s}>"+string.to_s+'</div>'
  end
  
end