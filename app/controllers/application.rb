# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  layout :set_layout 
  
  #Access constants
  CONTROLLER_ACCESS = 0
  ACTION_ACCESS_TYPES = {}
  
  PUBLIC = User::PUBLIC
  ACN_MEMBER = User::ACN_MEMBER
  SITE_MEMBER = User::SITE_MEMBER
  COMPONENT_RIGHT_OWNER = User::COMPONENT_RIGHT_OWNER
  
  before_filter :init, :init_areas # :check_query
  around_filter :catch_exceptions
  
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
  
  def init_areas force = false
    if not request.xhr? or force
      @template_areas = TemplateArea.get_areas_for_site current_site
    end
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
    session['user_sites'].include?(current_site.id)
  end
  
  def save_verbose obj
    unless (saved = obj.save)
      session['error_objects'].push obj
    end
    saved
  end

  def is_portal?
    current_site.is_portal?    
  end
  
  ################# protected #################
  protected
  
  def add_breadcrumb name, url = ''  
    @breadcrumbs ||= []  
    url = eval(url) if url =~ /_path|_url|@/  
    @breadcrumbs << [name, url]  
  end  
  
  def self.add_breadcrumb name, url = '', options = {}  
    before_filter options do |controller|  
      controller.send(:add_breadcrumb, name, url)  
    end  
  end
  
  ################# private #################
  private

  def init
    init_site
    add_breadcrumb 'Home', '/'

    $page = params[:page].nil? ? 1 : params[:page]
    
    self.class.static_session = session
    @logged_in = !session['user'].nil?
    session['error_objects'] = []
    @user = current_user
    @user_belongs_to_site = user_belongs_to_site? ? true : false
    $user_id = @user.id unless @user.nil?
    
    init_access
  end

  def set_layout
    current_site.template.internal_name
  end

  def init_site
    self.class.current_site = Site.find_by_subdomain(current_subdomain || "portal" )
    $site_id = current_site.id
  end
  
  def init_access
    return if self.class.user_has_right_for? params[:action]
    
    denied_msg = RAILS_ENV == "production" ? "access denied!" :  "access denied: you don't have right -> #{verbose_deny_message}"
    render :text => denied_msg
  end  

  def self.user_has? right
    return true
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
  
  def catch_exceptions
    begin
      yield
    rescue ActiveRecord::RecordNotFound
      render :template => "errors/RecordNotFound"
    #rescue NoMethodError
     # render :text => "no method exception"
    end
  end
end
