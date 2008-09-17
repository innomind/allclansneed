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
  
  before_filter :init_site_id
  
  @site_id
  
  def init_site_id
    @site_id = 1
  end
  
  protected
  
  def show()
      Guestbook.show_model(params[:page], @site_id)
  end
end



def user
  
  def initialize
    $session = 2
  end

end
