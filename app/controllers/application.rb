# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  layout :set_layout 
  
  before_filter :init, :init_areas # :check_query
  around_filter :catch_exceptions
  
  protected
  
  def init_areas force = false
    if not request.xhr? or force
      @template_areas = TemplateArea.get_areas_for_site current_site
    end
  end

  def current_site
    @site
  end
  
  def current_user
    @user
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
    init_user 
    
    add_breadcrumb 'Home', '/'

    $page = params[:page].nil? ? 1 : params[:page]
    I18n.locale = :de
    init_access
    debugger unless params[:debug].nil?
    return
  end

  def init_user
    unless session['user'].nil?
      @user = User.find session['user'] #, :joins => [:sites, :components]
      @user.logged_in = true
      @user.current_site = @site
      session['error_objects'] = [] 
      
      $user_belongs_to_site = @user.belongs_to_current_site? || false
      $user_id = @user.id unless @user.nil?
    end
  end

  def set_layout
    current_site.template.internal_name
  end

  def init_site
    server = request.server_name.split(".")
    server.delete_at(0) if server[0] == "www"
    if server.count == 2
      site = Site.find_by_subdomain(server[0])
    else
      site = Site.find_by_domain(server.join("."))
    end
    #self.class.current_site = site || Site.find_by_subdomain("portal")
    @site = site || Site.find_by_subdomain("portal")
    
    $site_id = current_site.id
  end
  
  def init_access
    return false if @user.nil?
    controller = self.class.to_s.underscore.gsub(/_controller$/, '')
    check = {:controller => controller, :action => params[:action]}
    return if @user.can_access? check
    
    denied_msg = "du darfst das nicht"
    render :text => denied_msg
  end

  def catch_exceptions
    begin
      yield
    rescue ActiveRecord::RecordNotFound
      render :template => "errors/RecordNotFound"
    rescue Exceptions::Access
      render :template => "errors/Access"
    #rescue NoMethodError
    # render :text => "no method exception"
    end
  end
end
