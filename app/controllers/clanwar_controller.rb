class ClanwarController < ApplicationController
  
  def index
    @clanwars  = Clanwar.paginate_by_site_id(current_site_id, :page => params[:page], :order => 'played_at DESC', :per_page => @per_page)
  end
  
  def show
    @clanwar = Clanwar.find_by_id(params[:id])
  end
  
  def new
    @clanwar = Clanwar.new
    @squads = Clan.find_for_site(:first).squads
    2.times { @clanwar.clanwar_maps.build }
    
  end
  
  def create
    @clanwar = Clanwar.new(params[:clanwar])
    @clanwar.site = current_site
    @clanwar.user = current_user
     
    if @clanwar.save
      redirect_to :action => 'index'
    else
      render :action => "new"
    end
  end
  
  def edit
    @clanwar = Clanwar.find_by_id(params[:id])
    @squads = Clan.find_for_site(:first).squads
  end
  
  def update
    @clanwar = Clanwar.find_by_id(params[:id])
    if @clanwar.update_attributes(params[:clanwar])
      redirect_to :action => 'index'
    else
      render :action => "edit"
    end
  end
end