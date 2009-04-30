class LoginController < ApplicationController
  def login
    nick = params[:user][:login].underscore
    pw = params[:user][:password]    
    unless (nick.nil? || pw.nil?)
      usr = User.first :conditions => {:login => nick}
      flash[:error] = "User-ID unbekannt" and render :action => 'index' and return if usr.nil?
      unless usr.email_activation_key.nil?
        flash[:error] = "Dein Account ist noch nicht aktiv. Du musst ihn mit dem Link, den wir dir per email zugeschickt haben aktivieren. Bei Problemen melde dich bei support@allclansneed.de"
        redirect_to :action => "index" and return
      end
      
      if usr.check_pw(pw)
        session['user'] = usr.id
        @logged_in = true
        flash[:notice] = 'erfolgreich eingeloggt'
        redirect_to :controller => "profile", :action => "start" and return
      else
        flash.now[:error] = "Passwort falsch<br><b>Wichtig!</b> Falls du bereits Mitglied im 'alten' Allclansneed warst musst du dich leider neu registrieren."
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
  
  def request_password
  end
  
  def send_password
    @new_pw_user = User.find_by_email params[:user][:email]
    if @new_pw_user.nil?
      flash[:error] = "Es wurde kein User zu der Email Adresse gefunden"
      render :action => "request_password"
    else
      @new_pw_user.generate_password_reset_key
      Postoffice.deliver_reset_password(@new_pw_user)
      flash[:notice] = "Der Link zum Anlegen eines neuen Passwortes wurde an #{@new_pw_user.email} verschickt."
      redirect_to :action => "index"
    end
  end
  
  def new_password
    @new_pw_user = User.find_by_password_reset_key params[:k]
    if @new_pw_user.nil? || params[:k].nil?
      flash[:error] = "Der Key für die Widerherstellung des Passworts ist falsch. Versuchen Sie es bitte noch einmal. Falls der Fehler dennoch auftritt, Kontaktieren Sie bitte unseren Support unter support@allclansneed.de"
      redirect_to :controller => "login"
    end
  end
  
  def save_password
    @new_pw_user = User.find_by_password_reset_key params[:k]
    if @new_pw_user.nil? || params[:k].nil?
      flash[:error] = "Der Key für die Widerherstellung des Passworts ist falsch. Versuchen Sie es bitte noch einmal. Falls der Fehler dennoch auftritt, Kontaktieren Sie bitte unseren Support unter support@allclansneed.de"
      redirect_to :controller => "login"
    else
      @new_pw_user.set_password params[:user][:password]
      if @new_pw_user.save
        @new_pw_user.password_reset_key = nil
        flash[:notice] = "Passwort wurde erfolgreich geändert, du kannst dich jetzt mit dem neuen passwort einloggen"
        redirect_to :action => "index"
      else
        render :action => "new_password"
      end
    end
  end
end