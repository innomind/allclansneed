class SquadUserController < ApplicationController

  before_filter :init_squad
  #after_filter :update_squad

  def show
    edit
    render :action => 'edit'
  end
  
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
    @user = User.find(params[:id])
    render :layout => false
  end

  def delete
    #@user = User.find(params[:id])
    #render :layout => false
    #let's be quick and lazy'
    #no extra template inbetween here
    destroy
  end

  def destroy
    @user = User.find(params[:id])
    unless @user.squads.length <= 1
      #bad double query
      if @squad.users.delete(@user)
        if @squad.save
          flash.now[:notice] = "User aus squad gelöscht"
        else
          flash.now[:error] = "User konnte nicht gelöscht werden"
        end
      end
    else
      flash.now[:error] = "User kann nicht aus letztem squad entfernt werden"
    end
    render :action => 'index'
  end

  def move
    @user = User.find(params[:user_id])
    render :layout => false
  end

  def do_move
    @user = User.find(params[:user_id])
    @target_squad = Squad.find(params[:target_squad])
    do_transfer :move
    render :action => 'index'
  end

  def copy
    @user = User.find(params[:user_id])
    render :layout => false
  end

  def do_copy
    @user = User.find(params[:user_id])
    @target_squad = Squad.find(params[:target_squad])
    do_transfer :copy
    render :action => 'index'
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


  #def update_squad
  # @squad.reload
  #end
end

