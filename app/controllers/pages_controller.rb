class PagesController < ApplicationController
  uses_tiny_mce :options => {:theme => "advanced", 
                             :plugins => [:emotions],
                             :theme_advanced_buttons1_add => [:emotions],
                             #:theme_advanced_disable => [:styleselect, :formatselect, :outdent, :indent, :anchor, :image, :cleanup, :code, :help, :separator, :removeformat, :sub, :sup, :stub, :visualaid, :charmap]
                             }, 
                :except => [:index, :show, :destroy]
  before_filter :init_breadcrumb, :except => [:show]
  def index
    @pages = Page.find :all
  end

  def show
    @page = Page.find params[:id]
    add_breadcrumb @page.title
  end

  def new
    @page = Page.new
    add_breadcrumb 'Seite erstellen'
  end

  def create
    @page = Page.new(params[:page])
    if @page.save
      flash[:notice] = "Seite erfolgreich erstellt"
      redirect_to page_path(@page)
    else
      render :action => "new"
    end
  end

  def edit
    @page = Page.find params[:id]
    add_breadcrumb 'Seite bearbeiten'
  end

  def update
    @page = Page.find params[:id]
    if @page.update_attributes(params[:page])
      flash[:notice] = "Seite erfolgreich geändert"
      redirect_to pages_path
    else
      render :action => "edit"
    end
  end

  def destroy
    flash[:notice] = "Seite gelöscht" if Page.find(params[:id]).destroy 
    redirect_to pages_path
  end
  
  private
  def init_breadcrumb
    add_breadcrumb 'Seite verwalten'
    add_breadcrumb 'Eigene Seiten verwalten'
  end
end
