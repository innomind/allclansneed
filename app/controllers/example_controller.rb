class ExampleController < ApplicationController
  def example
  end

  def index
    #@examples = Example.find :all
    #$site_id = 2
    @examples = Example.find_for_site :all
    
    @userid = session.data[:user_id]
    render :action => 'example'
  end

end
