class ShoutboxController < ApplicationController
  
  def create
    @shout = Shoutbox.new(params[:content])
    if @shout.save
      return if request.xhr?
    end
  end

end
