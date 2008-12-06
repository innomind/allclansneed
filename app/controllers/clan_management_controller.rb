class ClanManagementController < ApplicationController
  
  CONTROLLER_ACCESS = ACN_MEMBER
  ACTION_ACCESS_TYPES={
    :index => COMPONENT_RIGHT_OWNER
  }
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
  
  #TODO: clean up this shit, it's the opposite of dry (and toooo big)
  # bit it's structured a little bit and i'm very proud of it ;)
  def squad_member
    @squad1 = Squad.find params[:squad1] unless params[:squad1].nil?
    @squad2 = Squad.find params[:squad2] unless params[:squad2].nil?
    @member = User.find params[:member] unless params[:member].nil?
    #render :text => @squad1.name+" ->  "+@squad2.name+": "+@member.nick
    task = params[:commit]
    
    #TASK: move
    if (task == 'move ->' || task == '<- move')
      unless @member.nil?
        if (task == 'move ->')? 
            Squad.move_user(@member, @squad1, @squad2) : 
            Squad.move_user(@member, @squad2, @squad1)
    
          flash.now[:notice] = "user #{@member.nick} moved"
        else
          flash.now[:error] = "tranfer error"        
        end
      else
        flash.now[:error] = "no member selected"
      end

      #TASK: copy
    else if (task == 'copy ->' || task == '<- copy')
        unless @member.nil?
          if (task == 'copy ->')? 
              Squad.copy_user(@member, @squad1, @squad2) : 
              Squad.copy_user(@member, @squad2, @squad1)
    
            flash.now[:notice] = "user #{@member.nick} copied"
          else
            flash.now[:error] = "tranfer error"        
          end
        else
          flash.now[:error] = "no member selected"
        end
      
        #TASK: delete squad
      else if (task=='delete squad')
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
          
          #TASK: delete user
        else if (task=='del')
            unless @member.nil?
              unless @member.squads.length == 1
                @member.squads.delete((form == "1") ? @squad1 : @squad2)
              else
                flash.now[:error] = "can't remove user from his last squad"
              end
            else
              flash.now[:error] = "no member selected"
            end
          else
            #render :text => 'strange request'
            #return
          end
        end
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
      render :text => 'no clan given'+'  '+params.inspect
      return
    end
    @squad1 = @clan.squads[0] if @squad1.nil?
    @squad2 = @clan.squads[1] if @squad2.nil?
  end

end
