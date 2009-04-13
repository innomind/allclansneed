# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base

  helper :all # include all helpers, all the time
  layout :set_layout 
  
  before_filter :init  # :check_query
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
  
  def self.comment_mce_for only = :show
    uses_tiny_mce :options => {:theme => "advanced", 
                             :plugins => [:emotions],
                            :width => "auto",
                             :theme_advanced_buttons1 => [:bold, :italic, :emotions],
                             :theme_advanced_buttons2 => "",
                             :theme_advanced_buttons3 => ""
                            },
                :only => only
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

  def set_layout
    current_site.template.internal_name
  end

  def init
    init_site
    init_stylesheets
    init_user

    add_breadcrumb 'Home', '/'

    $page = params[:page].nil? ? 1 : params[:page]
    I18n.locale = :de
    
    init_areas
    
    init_access
    debugger unless params[:debug].nil?
    return
  end

  def init_user
    @current_session = Session.new
    @current_session.set_controller self.class.to_s.underscore.gsub(/_controller$/, '')
    unless session['user'].nil?
      @user = User.find session['user']# , :joins => [{:squads => :clan}, :sites, :components, :clan_ownerships, :site_ownerships]
      @user.logged_in = true
      @user.current_site = @site
      session['error_objects'] = [] 
      @current_session.set_user @user
      
      $user_belongs_to_site = @current_session.belongs_to_current_site? || false
      $user_id = @user.id unless @user.nil?
    end
  end

  def init_site
    server = request.server_name.split(".")
    server.delete_at(0) if server[0] == "www"
    if server.count == 3
      site = Site.find_by_sub_domain(server[0])
    else
      site = Site.find_by_domain(server.join("."))
    end
    
    #self.class.current_site = site || Site.find_by_subdomain("portal")
    @site = site || Site.find_by_sub_domain("portal")
    $site_id = current_site.id
  end
  
  def init_stylesheets
  end
  
  def init_access
    controller = self.class.to_s.underscore.gsub(/_controller$/, '')
    check = {:controller => controller, :action => params[:action]}
    return if @current_session.can_access? check #Rights.lookup_class(check[:controller], check[:action]) == "public"
    #return if @user.can_access? check
    render :template => "errors/Access"
  end

  def catch_exceptions
    begin
      yield
    rescue ActiveRecord::RecordNotFound
      render :template => "errors/RecordNotFound"
    rescue Exceptions::Access
      render :template => "errors/Access", :layout => !request.xhr?
    #rescue
    #  render :template => "errors/general", :locals => {:error => "ups. Irgendetwas ging da schief. Bitte wende dich an den Support."}
    end
  end
end
