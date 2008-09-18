class LoginController < ApplicationController
  
  def login
    nick = params[:nick]
    pw = params[:password]
    unless (nick.nil? || pw.nil?)
      acc = Account.first :conditions => {:nick => nick}
      if !acc.nil? && acc.check_pw(pw)
        session['account_id'] = acc.id;
        session['site_id'] = acc.site_id;
      else
        flash[:notice] = 'login failed'+' for '+params[:nick]
      end
      
    end
    render :action => 'index';
  end
  
  def index
    
  end

  def create
    unless params['account'].nil?
      @account = Account.new params['account']
      @account.site_id = params['site_id']
      if !@account.save
        flash[:errors] = @account.errors;
      else
        render :partial => 'create_success'
      end
    end
    @pages = Site.all
  end
end
