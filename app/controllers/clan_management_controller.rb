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
    if save_verbose @squad
      flash.now[:notice] = 'Squad successfully created.'
      @squad2 = @squad
    else
      flash.now[:error] = "Squad couldn't be created"
    end
    @clan.reload
    render :action => 'index'
  end

  def show_members
    @members = @clan.members
  end
  
  def squad_member
    @squad1 = Squad.find params[:squad1] unless params[:squad1].nil?
    @squad2 = Squad.find params[:squad2] unless params[:squad2].nil?
    @member = User.find params[:member] unless params[:member].nil?
    #render :text => @squad1.name+" ->  "+@squad2.name+": "+@member.nick
    task = params[:commit]
    
    #TASK: move
    if (task == '->' || task == '<-')
      unless @member.nil?
        if (task == '->')? 
            Squad.transfer_user(@member, @squad1, @squad2) : 
            Squad.transfer_user(@member, @squad2, @squad1)
    
          flash.now[:notice] = "user #{@member.nick} moved"
        else
          flash.now[:error] = "tranfer error"        
        end
      else
        flash.now[:error] = "no member selected"
      end
      
      #TASK: delete
    else if (task=='delete')
        unless (form = params[:form]).nil?
          if @clan.squads.length > 1
            if ((form == "1") ? @squad1 : @squad2).members == []
              ((form == "1") ? @squad1 : @squad2).destroy
              @clan.reload
              if @squad1.frozen?
                @squad1 = @clan.squads[0]
              end
              if @squad2.frozen? || @clan.squads.length == 1
                @squad2 = nil
              end
            end
          else
            flash.now[:error] = "can't remove last squad!"           
          end
        else
          render :text => 'delete non-empty squad request'
          return
        end
      else
        render :text => 'strange request'
        return
      end
    end

    render :action => 'index'
  rescue NoMethodError
    render :text => 'certain post-value is missing... param-error:<br/>'+$!
  end
  
  def update

    respond_to do |format|
      if @clan.update_attributes(params[:clan])
        flash.now[:notice] = 'Clan was successfully updated.'
        format.html { redirect_to(@clan) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @clan.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  private
  

  
  
  #TODO: get clan by id
  def init_clan
    @clan  = Clan.find_for_site :first
    if @clan.nil?
      render :text => 'no clan given'
      return
    end
    @squad1 = @clan.squads[0] if @squad1.nil?
    @squad2 = @clan.squads[1] if @squad2.nil?
  end

end
