module ClanwarHelper
  def add_map_link(name)
    link_to_function name do |page|
      page.insert_html :bottom, :clanwar_maps, :partial => 'newmap', :object => ClanwarMap.new
    end
  end
end
