class SearchController < ApplicationController
  add_breadcrumb "Suche"
  def index
    @clans = Clan.find :all, :conditions => ["uniq LIKE ?", "%#{params[:search]}%" ]
    @users = User.find :all, :conditions => ["login LIKE ?", "%#{params[:search]}%" ]
  end
end
