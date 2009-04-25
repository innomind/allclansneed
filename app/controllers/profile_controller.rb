class ProfileController < ApplicationController
  before_filter :get_profile, :only => [:show, :infobox]
  before_filter :init_clan, :only => [:index]
  comment_mce_for
  add_breadcrumb "User", "profiles_path"
  
  #TODO: Userliste
  def index
    @squads = @clan.squads.find(:all, :include => :users)
  end
  
  def show
    add_breadcrumb @profile.user.nick
  end
  
  def new
    @new_user = User.new
  end
  
  def create
    @new_user = User.create params[:user]
    if @new_user.save
      Postoffice.deliver_example("neuer user")
      flash[:notice] = "Du hast dich erfolgreich registriert. Du kannst dich jetzt einloggen"
      redirect_to :controller => "login"
    else
      @new_user.password = ""
      render :action => "new"
    end
  end
  
  def edit_pic
    add_breadcrumb current_user.nick, "profile_path(#{current_user.id})"
    add_breadcrumb "bearbeiten"
  end
  
  def update_pic
    current_user.update_attributes(params[:user])
    if current_user.save
      redirect_to profile_path(current_user.id)
    else
      render :action => "edit_pic"
    end
  end
  
  def edit
    @profile = current_user.profile
    add_breadcrumb @profile.user.nick, "profile_path(#{@profile.user.id})"
    add_breadcrumb "bearbeiten"
  end
  
  def update
    @profile = current_user.profile
    add_breadcrumb @profile.user.nick, "profiles_path(@profile.user.id)"
    add_breadcrumb "bearbeiten"
    @profile.user.update_attributes(params[:profile].delete(:user))
    @profile.update_attributes(params[:profile])
    if @profile.save
      #flash[:notice] = "Profil erfolgreich geändert"
      redirect_to profile_path(@profile.user_id)
    else
      render :action => "edit"
    end
  end
  
  #persönliche Startseite
  def start
    @pending_friends_for_me = current_user.pending_friends_for_me
    @pending_friends_by_me = current_user.pending_friends_by_me
    
    @pending_groupmemberships = Groupmembership.find :all, :conditions => ["status = ? AND group_id IN (?)", "pending", current_user.groupfounderships]
  end
  
  def infobox
    render :layout => false
  end
  
  protected
  
  def init_clan
    @clan = current_site.clan
  end
  
  def get_profile

    @profile = Profile.find params[:id], :include => [{:user => {:squads => :clan}}]
    
    unless current_site.is_portal?
      redirect_to profile_path(params[:id], :subdomain => false) and return unless @profile.user.belongs_to_site?(current_site)
    end
    
    @current_user = current_user
    if @profile.user != current_user && @current_session.logged_in?
      @friends_of_both = (@profile.user.friends & @current_user.friends)
      if (@profile.user.is_friends_with? @current_user)
         @connection = "direct"
      elsif ((@profile.user.friends & @current_user.friends).length > 0)
         @connection = "indirect"
         @friend_of_both = @friends_of_both[rand(@friends_of_both.length)]
      else
         @connection = "none"
      end
    end
  end
end