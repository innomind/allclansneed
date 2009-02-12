class NavigationController < ApplicationController
  def edit_box
    @navigations = Navigation.find :all, :conditions => { :template_box_id => params[:template_box_id]}
    render :layout => false
  end
end
