class ExampleController < ApplicationController
  def example
  end

  def index
    #@examples = Example.find :all
    @examples = Example.find :all
    
    @userid = session.data[:account_id]
    render :action => 'example'
  end

end
