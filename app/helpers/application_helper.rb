# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  #returns a formated date-string
  
  def german_date_with_time(datum)     
    datum.strftime("%d.%m%.%Y %H:%M")
  end
  
  def cloud(categories)
    return if categories.blank?
      output = ""
      mid = categories.collect {|i| i.news.count}.max / 1.5
      
      categories.each do |c|
          size = 100 * c.news.count / mid
          size = 75 if size < 75
          output << link_to(c.name, {:controller => "news_category",
                                    :action  => "show",
                                    :id  => c.id},
                                    :style => "font-size: #{size}%") << " "
      end
      return output               
  end

end
