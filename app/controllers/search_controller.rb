class SearchController < ApplicationController
  add_breadcrumb "Suche"
  def index
    @clans = Clan.find :all, :conditions => ["uniq LIKE ?", "%#{params[:search]}%" ], :limit => 50
    @users = User.find :all, :conditions => ["login LIKE ?", "%#{params[:search]}%" ], :limit => 50
  end
end
