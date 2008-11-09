class ProfileController < ApplicationController
  def index
    @profile = Profile.find_by_user_id(params[:id]);
  end
  
  def edit
    @profile = current_user.profile
  end
  
  def update
    @profile = current_user.profile
    @profile.update_attributes(params[:profile])
    if @profile.save
       redirect_to :action => "index", :id => @profile.user_id
    else
      render :action => "edit"
    end
  end
end
