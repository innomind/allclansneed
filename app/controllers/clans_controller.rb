class ClansController < ApplicationController
  add_breadcrumb "Clans Verwalten", "my_clans_path", :except => [:index, :show]
  before_filter :init_clan, :only => [:update, :leave, :edit]
  before_filter :check_member, :only => [:leave]
  before_filter :check_owner, :only => [:edit, :update]
  
  comment_mce_for
  
  def index
    add_breadcrumb "Clan Liste"
    @clans = Clan.paginate :page => params[:page], :per_page => 25, :order => :uniq
  end

  def my
    @clans = current_user.clans
    @inquiries = ClanJoinInquiry.find_all_by_user_id current_user.id
  end

  def show
    add_breadcrumb "Clan Liste", "clans_path"
    @clan = Clan.find params[:id], :include => {:squads => {:squad_users => :user}}
    add_breadcrumb @clan.name 
  end

  def new
    add_breadcrumb 'Clan gründen'
    @clan = Clan.new
  end

  def create
    add_breadcrumb 'Clan gründen'
    @clan = Clan.new params[:clan]
    @clan.owner = current_user
    if @clan.save
      flash[:notice] = "Clan erfolgreich erstellt"
      redirect_to my_clans_path
    else
      render :action => "new"
    end
  end
  
  def edit
    add_breadcrumb @clan.name + " bearbeiten"
  end
  
  def update
    if @clan.update_attributes(params[:clan])
      flash[:notice] = "Clan erfolgreich geändert"
      redirect_to my_clans_path
    else
      render :action => :edit
    end
  end
  
  def leave
    current_user.leave_clan @clan
    flash[:notice] = "Erfolgreich aus dem Clan ausgetreten"
    redirect_to my_clans_path
  end
  
  
  def search
    
  end
  
  def do_search
    
  end
  
  private
  
  def init_clan
    @clan = Clan.find params[:id]
  end
  
  def check_member
    raise Exceptions::Access unless current_user.belongs_to_clan? @clan
  end
  
  def check_owner
    raise Exceptions::Access unless current_user.owns_clan? @clan
  end
end
