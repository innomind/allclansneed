class LoginController < ApplicationController
   def login
     nick = params[:user][:login].underscore
     pw = params[:user][:password]
     unless (nick.nil? || pw.nil?)
       usr = User.first :conditions => {:login => nick}
       if !usr.nil? && usr.check_pw(pw)
         session['user'] = usr.id
         #session['user_sites'] = usr.sites
         session['']
         @logged_in = true
         flash[:notice] = 'erfolgreich eingeloggt'
         redirect_to :controller => "profile", :action => "start" and return
       else
         flash.now[:error] = "Username oder Passwort falsch<br><b>Wichtig!</b> Falls du bereits Mitglied im 'alten' Allclansneed warst musst du dich leider neu registrieren."
       end
     else
       flash.now[:error] = 'Nick nicht gefunden'
     end
     render :action => 'index'
   end
   
   def logout
     reset_session
     @logged_in = false
     flash[:notice] = "erfolgreich ausgeloggt"
     redirect_to root_path
   end
     
   def index
     render :layout => false if request.xhr?
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