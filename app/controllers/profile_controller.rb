class ProfileController < ApplicationController
  before_filter :get_profile, :only => [:show]
  
  #TODO: Userliste
  def index
    
  end
  
  def show
    @current_user = current_user
    
    if @profile.user != current_user
      #if there is a direct connection between the current_user and the profile which is currently viewed
    
    #todo
      
     #if (@profile.user.is_friends_with? @current_user)
     #  @connection = "direct"
     #elsif ((@profile.user.friends & @current_user.friends).length > 0)
     #  @connection = "indirect"
     #  #wenn beide mehrere freunde gemeinsam haben wird einer zufällig ausgewählt
     #  @friends_of_both = (@profile.user.friends & @current_user.friends)
     #  @friend_of_both = @friends_of_both[rand(@friends_of_both.length)]
     #else
     #  @connection = "none"
     #end
    end
  end
  
  def edit
    @profile = current_user.profile
  end
  
  def update
    @profile = current_user.profile
    @profile.update_attributes(params[:profile])
    if @profile.save
       redirect_to :action => "index", :id => @profile.user_id
    else
      render :action => "edit"
    end
  end
  
  #persönliche Startseite
  def start
    
  end
  
  protected
  
  def get_profile
    if is_portal?
      @profile = Profile.find_by_user_id(params[:id])
    else
      #TODO nur user für diese Seite anzeigen      
      #geht nicht:
      user = User.find :first, 
                       :conditions => ["users.id=? AND user_rights.site_id = ?",params[:id],current_site.id],
                       :joins => [:sites, :profile]
      if user.nil?
        redirect_to profile_path(params[:id], :subdomain => false) 
      else
        @profile = user.profile
      end
    end
  end
end