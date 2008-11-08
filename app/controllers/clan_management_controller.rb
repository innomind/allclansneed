class ClanManagementController < ApplicationController
  
  ACTION_LEVELS={:index => LEVEL_SITE_MEMBER}
  
  before_filter :init_clan
  
  def clan_management
    
  end
  
  def index
    respond_to do |format|
      format.html
      format.xml  { render :xml => @clan }
    end
  end
  
  def update_squads
    render :update do |page|
      page.list_squads @clan.squads
    end
  end

  def update_lists
    update_squads
  end
  
  def create_squad
    @squad = Squad.new(params[:squad])
    @squad.clan = @clan
    if @squad.save
      flash[:notice] = 'Clan successfully created.'
    else
      flash[:error] = "Clan couldn't be created"
    end
    redirect_to :controller => 'clan_management'
  end

  def show_members
    
  end
  
  def update

    respond_to do |format|
      if @clan.update_attributes(params[:clan])
        flash[:notice] = 'Clan was successfully updated.'
        format.html { redirect_to(@clan) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @clan.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def init_clan
    
    @clan  = Clan.find_for_site :first
  end

end
