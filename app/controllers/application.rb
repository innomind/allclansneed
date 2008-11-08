# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  layout 'standard'
  #model :account
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery  :secret => 'b4966102579ebc6ad039fe761a621b88'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  
  ACTION_LEVELS = {}
  LEVEL_ACN_MEMBER = 0
  LEVEL_SITE_MEMBER = 1
  LEVEL_SITE_ADMIN = 2
  
  before_filter :init_site, :init_rights #:init_site_id#, :check_query
  
  protected
  
  #the global variable site_id should be the ONLY exception in usage of global vars
  #we should try to remove even this, as soon we have found a proper alternative
  def init_site
    if params[:site_id] == ""
      render :text => 'strange request: site_id set, but empty'
      return
    end
    $site_id = params[:site_id].nil? ? 1 : params[:site_id]
    @site = Site.find_by_id $site_id
  end
  
  def init_rights
    levels = self.class::ACTION_LEVELS
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
    @logged_in = !session['user'].id.nil?
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
    session['user'].id.nil?
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
    
end
