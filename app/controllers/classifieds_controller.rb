class ClassifiedsController < ApplicationController

  add_breadcrumb 'Kleinanzeigen', "classifieds_path"

  CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES={
    :index => PUBLIC,
    :show => PUBLIC
  }

  def index
    @classifieds = Classified.paginate :all
  end
  
  def show
    @classified = Classified.find(params[:id])
    add_breadcrumb @classified.name
  end
  
  def new
    add_breadcrumb "Kleinanzeige erstellen"
    @classified = Classified.new
  end
  
  def edit
    @classified = Classified.find(params[:id])
    add_breadcrumb @classified.name + "bearbeiten"
  end
  
  def create
    add_breadcrumb "Kleinanzeige erstellen"
    @classified = Classified.new(params[:classified])
    
    if @classified.save
      flash[:notice] = 'Anzeige erfolgreich erstellt'
      redirect_to classifieds_path
    else
      render :action => "new"
    end
  end
  
  def update
    @classified = Classified.find(params[:id])
    
    if @classified.update_attributes(params[:classified])
      flash[:notice] = 'Anzeige erfolgreich geändert.'
      redirect_to classifieds_path
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @classified = Classified.find(params[:id])
    if @classified.destroy
      flash[:notice] = 'Anzeige erfolgreich gelöscht'
    end
    redirect_to classifieds_path
  end
end
