class LoginController < ApplicationController
  ACTION_LEVELS = { 'test1' => LEVEL_SITE_MEMBER,
    'test2' => LEVEL_SITE_ADMIN,
    'test3' => 3
  }
  
  def login
    nick = params[:nick]
    pw = params[:password]
    unless (nick.nil? || pw.nil?)
      usr = User.first :conditions => {:login => nick}
      if !usr.nil? && usr.check_pw(pw)
        session['user'] = usr
        session['user_sites'] = usr.site_ids
      else
        flash.now[:notice] = 'login failed'+' for "'+params[:nick]+'"'
      end
      
    end
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
  
  def test1
    render :text => "Test1"
  end
  
  def test2
    render :text => "Test2"
  end
  
  def test3
    render :text => "Test3"   
  end
end
