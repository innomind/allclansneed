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
      Postoffice.deliver_email_activation(@new_user)
      flash[:notice] = "Du hast dich erfolgreich registriert. Nachdem du deine Email adresse bestätigt hast kannst du dich einloggen. Einen Link zur Bestätigung haben wir dir per Email geschickt"
      redirect_to :controller => "login"
    else
      @new_user.password = ""
      render :action => "new"
    end
  end
  
  def email_activation
    user = User.find_by_email_activation_key params[:k]
    if user.nil? || params[:k].nil?
      flash[:error] = "Der Email Aktivierungs Code ist leider Falsch. Bitte wende dich bei Problemen an support@allclansneed.de"
    else
      user.update_attribute("email_activation_key", nil)
      flash[:notice] = "Dein Account wurde Aktiviert, du kannst dich jetzt einloggen."
    end
    redirect_to :controller => "login"
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
    raise ActiveRecord::RecordNotFound if @profile.nil?
    
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