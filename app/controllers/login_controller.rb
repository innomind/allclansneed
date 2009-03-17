class LoginController < ApplicationController
   def login
     nick = params[:user][:nick]
     pw = params[:user][:password]
     unless (nick.nil? || pw.nil?)
       usr = User.first :conditions => {:login => nick}
       if !usr.nil? && usr.check_pw(pw)
         session['user'] = usr.id
         #session['user_sites'] = usr.sites
         session['']
         @logged_in = true
         flash[:notice] = 'login success'
         redirect_to :controller => "profile", :action => "start" and return
       else
         flash.now[:notice] = 'login failed'+' for "'+params[:nick]+'"'
       end
     else
       flash.now[:error] = 'no such nick'
     end
     render :action => 'index'
   end
   
   def logout
     reset_session
     @logged_in = false
     render :action => 'index'
   end
   
   def index
   end
   
   def create
     unless params['user'].nil?
       @user = User.new params[:user]
       @user.user_rights[0] = UserRight.new(:user_id => @user.id, :site_id => params[:site_id], :level => 1)
       if !@user.save
         flash[:errors] = @user.errors
       else
         render :partial => 'create_success'
       end
     end
     @pages = Site.all
   end
end