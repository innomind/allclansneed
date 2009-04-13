class ClanwarController < ApplicationController
  
  add_breadcrumb 'Clanwars', "clanwars_path"
  
  def index
    if params[:squad_id].nil?
      @squads = current_site.clan.squads
    else
      @squad = current_site.clan.squads.find params[:squad_id]
      @clanwars = @squad.clanwars.pages
      render "clanwar/index_clanwars"
    end
  end
  
  def show
    @clanwar = Clanwar.find_by_id(params[:id], :include => :clanwar_screenshots)
    add_breadcrumb "gegen "+@clanwar.opponent
  end
  
  def new
    @clanwar = Clanwar.new
    @squads = current_site.clan.squads
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