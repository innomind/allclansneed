class ClanwarController < ApplicationController
  
  def index
    @clanwars  = Clanwar.find_for_site(:all)
  end
end
