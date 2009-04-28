class SiteController < ApplicationController
  before_filter :check_owner, :only => [:new, :create]
  
  def index
    add_breadcrumb "Clanseitenliste"
    @sites = Site.paginate :page => params[:page], :include => :clan, :per_page => 25, :order => :sub_domain
  end
  
  def new
    @clan.site = Site.create(:owner_id => current_user.id, :sub_domain => @clan.uniq)
    @clan.save
    flash[:notice] = "Seite für den Clan erstellt"
    redirect_to my_clans_path
  end
  
  def create
    
  end
  
  def edit
    
  end
  
  def update
    if @site.update_attributes params[:site]
      flash[:notice] = "Seite erfolgreich gändert"
      redirect_to templates_path
    else
      render :action => :edit
    end
  end
  
  def toggle_header
    if session[:header_style] == "display:none"
      session[:header_style] = "" 
    elsif session[:header_style] == ""
      session[:header_style] = "display:none"
    end
    session[:header_style] = "display:none" if session[:header_style].nil?
    
    render :update do |page|
	  	page.visual_effect(:toggle_blind, "info_box")
	  end
  end
  
  private
  
  def check_owner
    @clan = Clan.find params[:clan_id]
    raise Exceptions::Access unless current_user.owns_clan? @clan
  end
end
