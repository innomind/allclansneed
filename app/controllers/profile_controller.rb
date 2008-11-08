class ProfileController < ApplicationController
  def index
    @user = User.find_by_id(params[:id]);
    render :controller => "Pinwall", :action => "index"
  end
  
  def update
    
  end
  
  def edit
    
  end
end
