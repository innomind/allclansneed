class PinwallController < ApplicationController
  def index
    #@p = Pinwall.new({:entry => "asdf"})
    #@p.save
    #@test = "blablabla";
    render :partial => "index"
  end
end
