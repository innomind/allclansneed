# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  #layout 'dnp'
  layout 'standard'

  
  #Access constants
  CONTROLLER_ACCESS = 0
  ACTION_ACCESS_TYPES = {}
  
  PUBLIC = User::PUBLIC
  ACN_MEMBER = User::ACN_MEMBER
  SITE_MEMBER = User::SITE_MEMBER
  COMPONENT_RIGHT_OWNER = User::COMPONENT_RIGHT_OWNER
  
  before_filter :init, :pagination_defaults, :init_areas # :check_query
  

  #make session available in static (class) context
  class_inheritable_accessor :static_session, :current_site
  
  
  protected


  def self.user_has_right_for? action
    needed = self::ACTION_ACCESS_TYPES
    action = action.to_sym
    right = needed[action].nil? ? self::CONTROLLER_ACCESS : needed[action]
    
    return true if right == PUBLIC
    return true if user_has? right
    false
  end
  
  def init_areas
    @template_areas = TemplateArea.find :all, 
      :conditions => {:template_id => current_site.template_id}, 
      :include => [ :template_boxes => 
        [ :template_box_type, 
        {:navigations => :navigation_template} ]
    ],
      :order => "template_boxes.position, navigations.position"
  end

  #deprecated, don't use
  def current_site_id
    $site_id
  end
  
  def logged_in?
    @logged_in
  end
  
  def user_is_guest?
    self.class.user_is_guest?
  end
  def self.user_is_guest?
    static_session['user'].nil?
  end
  
  def current_user_id
    session['user'].id
  end
  
  def current_user
    self.class.current_user
  end
  def self.current_user
    static_session['user']
  end
  
  def user_belongs_to_site?
    return false if session['user_sites'].nil?
    session['user_sites'].include?(current_site_id)
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


  def is_portal?
    current_site.is_portal?    
  end
  


  ################# private #################
  private

  def init
    init_site
    
    #some preparations
    self.class.current_site = Site.find_by_id $site_id
    self.class.static_session = session
    @logged_in = !session['user'].nil?
    session['error_objects'] = []
    
    init_access
  end

  #the global variable site_id should be the ONLY exception in usage of global vars
  #we should try to remove even this, as soon we have found a proper alternative
  #FIXME: please fix (and remove) or further explain the big fixme below
  def init_site
    if params[:site_id] == ""
      render :text => 'strange request: site_id set, but empty'
      return
    end
    $site_id = params[:site_id].nil? ? 1 : params[:site_id]
    ####FIXME  ahhhhh blöööödddd!!!  ---- wird in acts_as_delegatable als std wert gebraucht
    $page = params[:page].nil? ? 1 : params[:page]
  end
  
  def init_access
    return if self.class.user_has_right_for? params[:action]
    
    denied_msg = RAILS_ENV == "production" ? "access denied!" :  "access denied: you don't have right -> #{verbose_deny_message}"
    render :text => denied_msg
  end  

  def self.user_has? right
    return false if user_is_guest?
    user_right = current_user.local_right
    return false if user_right.nil?
    unless right == COMPONENT_RIGHT_OWNER
      true if (user_right.right_type & right) == right
    else
      true if static_session[:rights][current_site.id].include? self.to_s
    end
  end
  
  # since these consts should only be visible for development purposes
  # and i don't like fix lists, i search for them with simple regexps
  # not failsafe of course
  def verbose_deny_message
    right = self.class::ACTION_ACCESS_TYPES[params[:action].to_sym]
    right = self.class::CONTROLLER_ACCESS if right.nil?
    User.constants.select{ |c| c =~ /MEMBER|RIGHT|SITE|PUBLIC|PRIVATE/ }.select {|r| (eval "User::#{r}") == right}
  end
  
  #this doesn't work, must use facets plugin, then a trick seems to be possible
  #rescue NameError
  #    eval("self.class"+$!.message[/method \`(.*)'/, 1])
end
