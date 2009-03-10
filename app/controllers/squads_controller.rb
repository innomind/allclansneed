class SquadsController < ApplicationController

  def index

  end



  def show

  end


  def new
    @squad = Squad.new(params[:id])
  end


  def edit
    @squad = Squad.find(params[:id])
  end


  def create
    @squad = Squad.new(params[:squad])
    @clan = Clan.current
    @squad.clan = @clan
    if save_verbose @squad
      flash.now[:notice] = 'Squad successfully created.'
      @squad2 = @squad
    else
      flash.now[:error] = "Squad couldn't be created"
    end
    @clan.reload
    redirect_to :action => 'index'
  end

  def update
    @squad = Squad.find(params[:id])

  end


  def destroy
    @squad = Squad.find(params[:id])
    @squad.destroy

  end
end
