# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  #some stuff for tag-clouding :)
  include TagsHelper
  
  #returns a formated date-string  
  def german_date_with_time(datum)     
    datum.strftime("%d.%m%.%Y %H:%M")
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
end