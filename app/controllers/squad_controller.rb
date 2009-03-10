class SquadController < ApplicationController

  before_filter :init_clan
  def index
    
  end

  def new
    @squad = Squad.new
  end

  def create
    @squad = Squad.new
  end

  def edit
    @squad = Squad.find_by_id(params[:id])
  end

  private

  def init_clan
    @clan = Clan.current
  end
end
