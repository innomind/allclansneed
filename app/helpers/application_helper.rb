# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  #returns a formated date-string
  
  def german_date_with_time(datum)     
    datum.strftime("%d.%m%.%Y %H:%M")
  end

end
