class ClanwarController < ApplicationController
  
  def index
    @clanwars  = Clanwar.paginate_by_site_id(current_site_id, :page => params[:page], :order => 'played_at DESC', :per_page => @per_page)
  end
end