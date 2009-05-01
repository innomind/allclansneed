class UsersController < ApplicationController
  add_breadcrumb "Benutzer"
  def index
    @users = User.paginate :all, :per_page => 20, :page => params[:page], :order => "login"
  end
end
