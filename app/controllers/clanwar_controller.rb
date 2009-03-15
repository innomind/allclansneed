class ClanwarController < ApplicationController
  
  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES={
    :index => PUBLIC,
    :show => PUBLIC
  }

  add_breadcrumb 'Clanwars', "clanwars_path"
  
  def index
    @clanwars  = Clanwar.paginate :all
  end
  
  def show
    @clanwar = Clanwar.find_by_id(params[:id])
    add_breadcrumb "gegen "+@clanwar.opponent
  end
  
  def new
    @clanwar = Clanwar.new
    @squads = Clan.find(:first).squads
    2.times { @clanwar.clanwar_maps.build }
    add_breadcrumb 'Clanwar hinzufügen'
  end
  
  def create
    add_breadcrumb 'Clanwar hinzufügen'
    @clanwar = Clanwar.new(params[:clanwar])
    if @clanwar.save
      flash[:notice] = "Clanwar erfolgreich erstellt"
      redirect_to clanwars_path
    else
      @squads = Clan.find(:first).squads
      render :action => "new"
    end
  end
  
  def edit
    @clanwar = Clanwar.find_by_id(params[:id])
    @squads = Clan.find(:first).squads
    add_breadcrumb 'Clanwar bearbeiten'
  end
  
  def update
    @clanwar = Clanwar.find_by_id(params[:id])
    if @clanwar.update_attributes(params[:clanwar])
      flash[:notice] = "Clanwar erfolgreich geändert"
      redirect_to clanwars_path
    else
      render :action => "edit"
    end
  end
end