module ClanwarHelper
  def add_map_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :clanwar_maps, :partial => 'newmap', :object => ClanwarMap.new
    end
  end
  
  def show_score(my_score, opponent_score)
    if my_score > opponent_score
      color = "green"
  	elsif my_score < @clanwar.score_opponent
      color = "red"
  	else
  	  color = "yellow"
  	end
  	"<font color='#{color}'>#{my_score} : #{opponent_score} </font>"
  end
end
