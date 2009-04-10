class ProfileController < ApplicationController
  before_filter :get_profile, :only => [:show, :infobox]
  before_filter :init_clan, :only => [:index]
  comment_mce_for
  add_breadcrumb "Profile", "profiles_path"
  
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
      flash[:notice] = "Du hast dich erfolgreich registriert. Nachdem du deine Email Adresse bestätigt hast, kannst du dich einloggen"
      redirect_to :controller => "login"
    else
      render :action => "new"
    end
  end
  
  def edit
    @profile = current_user.profile
  end
  
  def update
    @profile = current_user.profile
    @profile.update_attributes(params[:profile])
    if @profile.save
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
    if is_portal? || (params[:action] == "infobox")
      @profile = Profile.find_by_user_id(params[:id])
    else
      #TODO nur user für diese Seite anzeigen      
      #geht nicht:
      user = User.find :first, :conditions => ["users.id=? AND user_rights.site_id = ?",params[:id],current_site.id], :joins => [:sites, :profile]
      if user.nil?
        redirect_to profile_path(params[:id], :subdomain => false) and return
      else
        @profile = user.profile
      end
    end
    
    @current_user = current_user
    if @profile.user != current_user && @current_session.logged_in?
      #if there is a direct connection between the current_user and the profile which is currently viewed
    
      #todo
      
      if (@profile.user.is_friends_with? @current_user)
         @connection = "direct"
      elsif ((@profile.user.friends & @current_user.friends).length > 0)
         @connection = "indirect"
         #wenn beide mehrere freunde gemeinsam haben wird einer zufällig ausgewählt
         @friends_of_both = (@profile.user.friends & @current_user.friends)
         @friend_of_both = @friends_of_both[rand(@friends_of_both.length)]
      else
         @connection = "none"
      end
    end
  end
end