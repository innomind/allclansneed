# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #layout 'standard'
  #model :account
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  #protect_from_forgery  :secret => 'b4966102579ebc6ad039fe761a621b88'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  before_filter :init_site_id, :check_query
  
  protected
  
  def init_site_id
    $site_id = params['site_id'].nil? ? 1 : params['site_id'] 
  end

  #def initialize
    
  #end
  
  def user_is_guest?
    session['account_id'].nil?
  end
  
  def current_user_site_id
    user_is_guest? ? 1 : session['account_id']
  end
  
  def current_user_id
    session['user_id']
  end
  
  def rights
    user_is_guest? ? [] : session['rights'].split(' ')
  end
  
  def current_account_id
    session['account_id']
  end
  
  
  #denylist is a whitespace seperated string of Controller/action
  def check_query
    complete_list =  Account::ALL_RIGHTS.split ' '
    
    request = params['controller'].capitalize+'/'+params['action']
    #render :text => 'complete: '+complete_list.inspect+'<br/><br/>'+'right:'+rights.inspect+'<br/><br/>'+'req: '+request
    if complete_list.include?(request) && !rights.include?(request)
      redirect_to root_path
    end
    
  end
end
