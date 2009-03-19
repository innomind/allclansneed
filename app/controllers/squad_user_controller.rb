class SquadUserController < ApplicationController

  before_filter :init_squad_user
  before_filter :check_owner, :only => [:edit, :update]

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
    component_list = params[:component_list].delete_if{|k,v| v == "0"}
    component_list.each do |co,v|
      UserRight.create(:user_id => @user.id, :site_id => current_site.id, :component_id => co)
      components.select{|comp| comp.id == co.to_i}.first.children.each{|comp| UserRight.create(:user_id => @user, :site_id => current_site.id, :component_id => comp.id)}
      #@user.components.push Component.find c
      #@user.user_rights << UserRight.create(:site_id => current_site.id, :user_id => @user.id, :right_type => c)
    end
    UserRight.create(:user_id => @user.id, :site_id => current_site.id) if component_list.empty?
    flash[:notice] = "User gespeichert"
    redirect_to squads_path
  end

  def destroy_form
    @msg = Array.new
    if @squad_user.user.squads_in_clan(@clan).count > 1
      squad = [["Squad", "squad"]]
    else
      squad = []
      @msg.push "Da der User nur in einem Squad ist, kann er nur komplett aus dem Clan gelöscht werden"
    end
    if (@squad_user.user.owns_clan? @clan)
      @msg.push "Der Clan besitzer kann nicht aus dem Clan entfernt werden"
      clan = []
    else
      clan = [["Clan", "clan"]]
    end
    @select = clan + squad
    render :layout => false
  end

  def destroy
    if params[:target][:type] == "clan"
      destroy_squads = @squad_user.user.squads_in_clan @clan
      UserRight.destroy_all(:user_id => @squad_user.user.id, :site_id => @clan.site.id)
    else
      destroy_squads = [@squad_user.squad]
    end
    @squad_user.user.squads -= destroy_squads
    flash[:notice] = "erfolgreich gelöscht"
    redirect_to squads_path
    
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

  def init_squad_user
    @squad_user = SquadUser.find_by_id params[:id]
    @squad = @squad_user.squad
    @clan = @squad.clan
    raise Exceptions::Access unless current_user.owns_clan? @clan
  end
  
  def check_owner
    raise Exceptions::Access if @squad_user.user.owns_clan? @clan
  end
  
  def squads_path
    {:controller => "squad", :action => "index", :clan_id => is_portal? ? @clan.id : nil}
  end
  
end