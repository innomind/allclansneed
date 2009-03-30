class ClanwarScreenshotController < ApplicationController
  before_filter :init_screenshot
  
  def new
    @screenshot = @clanwar.clanwar_screenshots.new
    render :layout => false
  end
  
  def create
    @screenshot = @clanwar.clanwar_screenshots.new params[:clanwar_screenshot]
    @screenshot.user = current_user
    if @screenshot.save
      flash[:notice] = "Screenshot hinzugefügt"
      redirect_to @clanwar
    else
      render :action => :new
    end
  end
  
  def destroy
    @screenshot = @clanwar.clanwar_screenshots.find params[:id]
    flash[:notice] = "Screenshot gelöscht" if @screenshot.destroy
    redirect_to @clanwar
  end
  
  def init_screenshot
    @clanwar = Clanwar.find params[:clanwar_id]
  end
end
