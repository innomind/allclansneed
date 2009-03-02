class SquadsController < ApplicationController

  def index

  end



  def show

  end


  def new

  end


  def edit
    @squad = Squad.find(params[:id])
  end


  def create
    @squad = Squad.new(params[:squad])


  end

  def update
    @squad = Squad.find(params[:id])

  end


  def destroy
    @squad = Squad.find(params[:id])
    @squad.destroy

  end
end
