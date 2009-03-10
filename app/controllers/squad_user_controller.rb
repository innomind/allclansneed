class SquadUserController < ApplicationController

  before_filter :init_squad

  def show
    edit
    render :action => 'edit'
  end
  
  def index
    #render :text => @clan.inspect
  end

  def new
    
  end

  def create
    user = User.new(params[:user])
    if user.save

      @squad.users << user
    end
    
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    if @squad.users.delete(User.find(params[:id]))
      if @squad.save
        flash.now[:notice] = "User aus squad gelöscht"
      end
    end
  end

  def move
    
  end

  def do_move
    do_transfer :move
  end

  def copy

  end

  def do_copy
    do_transfer :copy
  end

  private
  
  def init_squad
    @squad = Squad.find(params[:squad_id])
  end
  
  def do_transfer kind
    @user = User.find(params[:user_id])
    @target_squad = Squad.find(params[:target_squad])
    unless @user.nil?
      if eval("Squad.#{kind}_user(@user, @squad, @target_squat)")
        flash.now[:notice] = "user #{@member.nick} "+ (kind == :copy)? "kopiert": "verschoben"
      end
    else
      flash.now[:error] = "Tranfer fehlgeschlagen"
    end
  end
end

