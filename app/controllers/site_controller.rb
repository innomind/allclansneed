class SiteController < ApplicationController
  before_filter :check_owner, :only => [:new, :create]
  def new
    @clan.site = Site.create(:owner_id => current_user.id, :sub_domain => @clan.uniq)
    @clan.save
    flash[:notice] = "Seite für den Clan erstellt"
    redirect_to clans_path
  end
  
  def create
    
  end
  
  private
  
  def check_owner
    @clan = Clan.find params[:clan_id]
    raise Exceptions::Access unless current_user.owns_clan? @clan
  end
end
