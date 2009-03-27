class ModeratorController < ApplicationController

  add_breadcrumb 'Moderatoren'#, 'moderators_path'

  def index
    @moderators = Moderator.find :all
    @moderators.uniq
  end

  def show
    @mod = Moderator.find params[:id]
    add_breadcrumb username(@mod.user)
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
      redirect_to moderator_path
    else
      render :action => "edit"
    end
  end

  def destroy
    flash[:notice] = "Moderator gelöscht" if Moderator.find(params[:id]).destroy
    redirect_to moderator_path
  end
end
