class RightsManagementController < ApplicationController
  CONTROLLER_ACCESS = SITE_MEMBER
  
  before_filter :init_params
  
  def rights_management
    unless @user.nil?
      
      unless @add_component.nil?
        @user.components.push @add_component
        if @user.save
          flash.now[:notice] = "right added"
        else
          flash.now[:error] = "right not added"
        end
      else unless @del_component.nil?
          @user.components.delete @del_component
          if @user.save
            flash.now[:notice] = "right deleted"
          else
            flash.now[:error] = "right not deleted"
          end
        end
        @user.reload
      end
    
    end
  end

  def index
    
  end
  
  def init_params
    @user = User.find params[:user][:id] unless params[:user].nil?
    #render :partial => params.inspect
    unless params[:add].nil?
      @add_component = Component.find params[:component][:free] unless params[:component].nil?
    end
    unless params[:del].nil?
      unless params[:component].nil?
        unless params[:component][:user].nil?
          @del_component = Component.find params[:component][:user]
        else
          @del_component = nil
          flash.now[:error] = "no module selected"
        end       
      end
    end
    
  end
  
end
