class ProfileController < ApplicationController
  def index
    @profile = Profile.find_by_id(params[:id]);
  end
  
  def update
    
  end
  
  def edit
    
  end
end
