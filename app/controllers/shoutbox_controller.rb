class ShoutboxController < ApplicationController
  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES={
    :index => PUBLIC,
    :create => PUBLIC
  }
  
  def create
    @shout = Shoutbox.new(params[:content])
    if @shout.save
      return if request.xhr?
    end
  end

end
