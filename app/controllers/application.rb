# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  ####TEST

  helper :all # include all helpers, all the time
  #layout 'standard'
  layout 'dnp'
  #model :account
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery  :secret => 'b4966102579ebc6ad039fe761a621b88'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  #Access constants
  CONTROLLER_ACCESS = 0
  ACTION_ACCESS_TYPES = {}
  
  PUBLIC = User::PUBLIC
  ACN_MEMBER = User::ACN_MEMBER
  SITE_MEMBER = User::SITE_MEMBER
  COMPONENT_RIGHT_OWNER = User::COMPONENT_RIGHT_OWNER
  
  before_filter :init_site, :init_rights, :pagination_defaults, :init_areas #:init_site_id#, :check_query
  
  protected
    
  #the global variable site_id should be the ONLY exception in usage of global vars
  #we should try to remove even this, as soon we have found a proper alternative
  def init_site
    if params[:site_id] == ""
      render :text => 'strange request: site_id set, but empty'
      return
    end
    $site_id = params[:site_id].nil? ? 1 : params[:site_id]
    ####FIXME  ahhhhh blöööödddd!!!  ---- wird in acts_as_delegatable als std wert gebraucht
    $page = params[:page].nil? ? 1 : params[:page]
    @site = Site.find_by_id $site_id
  end
  
  def init_rights
    #some useful variables
    @logged_in = !session['user'].nil?
    session['error_objects'] = []
    
    # rights
    needed = self.class::ACTION_ACCESS_TYPES
    action = params[:action].to_sym
    #controller = params[:controller].to_sym
    
    right = needed[action].nil? ? self.class::CONTROLLER_ACCESS : needed[action]
    return if right == PUBLIC
    return if user_has? right
    
    denied_msg = RAILS_ENV == "production" ? "access denied!" :  "access denied: you don't have right -> #{verbose_right right}"
    render :text => denied_msg
    
=begin
    unless levels == {}
      request = :"#{params[:action]}"
      req_level = levels[request].nil? ? levels[:all] : levels[request]
      unless req_level.nil?
        if user_has_right_ge? req_level
          return
        else
          render :text => 'access denied'
        end
      end
    end
=end
  end
  
  def init_areas
    @area_list = TemplateArea.find(:all, :select => "internal_name", :conditions => {:template_id => current_site.template_id})
  end

  #deprecated, don't use
  def current_site_id
    $site_id
  end
  
  def current_site
    @site
  end
  
  def logged_in?
    @logged_in
  end
  
  def user_is_guest?
    session['user'].nil?
  end
  
  def current_user_id
    session['user'].id
  end
  
  def current_user
    session['user']
  end
  
  def user_belongs_to_site?
    if session['user_sites'].nil?
      false
    else
      session['user_sites'].include?(current_site_id)
    end
  end
  
  # user has right greater than/equal to level?
  #!! deprecated !! use user_has_right?
  def user_has_right_ge? level
    unless user_is_guest?
      right = UserRight.find :first, :conditions => {:site_id => current_site_id, :user_id => current_user_id}
      if right.nil?
        (level == LEVEL_ACN_MEMBER)
      else
        (right.level >= level)
      end
    else
      false
    end
  end
  
  
  def user_has? right
    return false if user_is_guest?
    user_right = current_user.local_right
    return false if user_right.nil?
    unless right == COMPONENT_RIGHT_OWNER
      true if (user_right.right_type & right) == right
    else
      true if session[:rights][current_site.id].include? self.class.to_s
    end
  end
  
  def save_verbose obj
    unless (saved = obj.save)
      session['error_objects'].push obj
    end
    saved
  end
  
  def pagination_defaults
    @page = (params[:page] || 1).to_i
    @page = 1 if @page < 1
    @per_page = (10 if params[:per_page].nil?).to_i
  end

  # since these consts should only be visible for development purposes
  # and i don't like fix lists, i search for them with simple regexps
  # not failsafe of course
  def verbose_right right
    User.constants.select{ |c| c =~ /MEMBER|RIGHT|SITE|PUBLIC|PRIVATE/ }.each do |r|
      return r if (eval "User::#{r}") == right
    end
  end
end
