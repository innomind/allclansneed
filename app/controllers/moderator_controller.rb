class ModeratorController < ApplicationController

  add_breadcrumb 'Moderatoren', 'moderators_path'

  def index
    @moderators = Moderator.find :all, :order => "user_id DESC"
  end

  def show
    @mod = Moderator.find(:all, :conditions => ["forum_id = ?", params[:id]])
  end

  def new
    @mod = Moderator.new
    add_breadcrumb 'Moderator hinzufügen'
  end

  def create
    @mod = Moderator.new(params[:moderator])
    if @mod.save
      flash[:notice] = "Moderator hinzugefügt"
      redirect_to moderator_path(@mod)
    else
      render :action => "new"
    end
  end

  def edit
    @mod = Moderator.find params[:id]
    add_breadcrumb 'Moderator bearbeiten'
  end

  def update
    @mod = Moderator.find params[:id]
    if @mod.update_attributes(params[:article])
      flash[:notice] = "Moderator erfolgreich geändert"
      redirect_to moderators_path
    else
      render :action => "edit"
    end
  end

  def destroy
    flash[:notice] = "Moderator gelöscht" if Moderator.find(params[:id]).destroy
    redirect_to moderators_path
  end
end
