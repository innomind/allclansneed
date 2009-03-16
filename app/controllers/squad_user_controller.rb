class SquadUserController < ApplicationController

  #before_filter :init_squad
  #after_filter :update_squad
  before_filter :init_clan
  before_filter :init_squad_user, :only => [:destroy_form, :destroy, :move, :do_move, :copy, :do_copy]
  
  def index
    render :layout => false
  end

  def new
    render :layout => false
  end

  def create
    user = User.new(params[:user])
    if user.save
      @squad.users << user
    end
    redirect_to :action => 'index'
  end

  def edit
    @components = Component.all :conditions => {:parent_id => nil}
    @user_components = @user.components
    render :layout => false
  end
  
  def update
    @user.user_rights.destroy_all
    components = Component.all
    params[:component_list].delete_if{|k,v| v == "0"}.each do |co,v|
      UserRight.create(:user_id => @user, :site_id => current_site.id, :component_id => co)
      components.select{|comp| comp.id == co.to_i}.first.children.each{|comp| UserRight.create(:user_id => @user, :site_id => current_site.id, :component_id => comp.id)}
      #@user.components.push Component.find c
      #@user.user_rights << UserRight.create(:site_id => current_site.id, :user_id => @user.id, :right_type => c)
    end
    flash[:notice] = "User gespeichert"
    redirect_to squads_path
  end

  def destroy_form
    if @squad_user.user.squads_in_clan(@clan).count > 1
      squad = [["Squad", "squad"]]
    else
      squad = []
      @msg = "Da der User nur in einem Squad ist, kann er nur komplett aus dem Clan gelöscht werden"
    end
    @select = [["Clan", "clan"]] + squad
    render :layout => false
  end

  def destroy
    if params[:target][:type] == "clan"
      destroy_squads = @squad_user.user.squads_in_clan @clan
    else
      destroy_squads = [@squad_user.squad]
    end
    @squad_user.user.squads -= destroy_squads
    flash[:notice] = "erfolgreich gelöscht"
    redirect_to squads_path
    
    #
    #unless @squad_user.user.squads_in_clan(@clan).length <= 1
    #  if @squad.users.delete(@user)
    #    if @squad.save
    #      flash.now[:notice] = "User aus squad gelöscht"
    #    else
    #      flash.now[:error] = "User konnte nicht gelöscht werden"
    #    end
    #  end
    #else
    #  flash.now[:error] = "User kann nicht aus letztem squad entfernt werden"
    #end
    #render :action => 'index'
  end

 
  def move
    @squad_select = (@clan.squads-@user.squads).collect{|s| [s.name,s.id]}
    render :layout => false
  end

  def do_move
    @target_squad = @clan.squads.find(params[:target_squad])
    do_transfer :move
    redirect_to squads_path
  end

  def copy
    @squad_select = (@clan.squads-@user.squads).collect{|s| [s.name,s.id]}
    render :layout => false
  end

  def do_copy
    @target_squad = @clan.squads.find(params[:target_squad])
    do_transfer :copy
    redirect_to squads_path
  end

  private
  
  def init_squad
    @squad = Squad.find(params[:squad_id])
    
    # rudimentary sec hack
    # not sure if our sec sys works cleanly at this point
    #FIXME: check your security and delete this
    render :text => '' unless Clan.current.squads.include? @squad unless @squad.nil?
    render :text => '' unless @squad.members.include? User.find(params[:id]) unless params[:id].nil?
  end
  
  def do_transfer kind
    unless @user.nil?
      if eval("Squad.#{kind.to_s}_user(@user, @squad, @target_squad)")
        flash.now[:notice] = "user #{@user.nick} "+((kind == :copy)? "kopiert" : "verschoben")
      end
    else
      flash.now[:error] = "Transfer fehlgeschlagen"
    end
    @squad.reload
  end
  
  def init_clan
    @clan = current_site.clan
  end

  def init_squad_user
    @squad_user = SquadUser.find_by_id params[:id], :conditions => ["squad_id IN (?)", @clan.squads]
    @user = @squad_user.user
    @squad = @squad_user.squad
  end
  
  #def update_squad
  # @squad.reload
  #end
end

