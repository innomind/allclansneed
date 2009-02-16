class ClassifiedsController < ApplicationController
  def index
    list
    render :action => 'list'
  end
  
  def list
    @classifieds = Classified.all
  end
  
  def show
    @classified = Classified.find(params[:id])
  end
  
  def new
    @classified = Classified.new
  end
  
  def edit
    @classified = Classified.find(params[:id])
  end
  
  def create
    @classified = Classified.new(params[:classified])
    @classified.user = current_user
    
    if @classified.save
      flash[:notice] = 'Classified was successfully created.'
      redirect_to :action => 'index'
    else
      render :action => "new"
    end
  end
  
  def update
    @classified = Classified.find(params[:id])
    
    if @classified.update_attributes(params[:classified])
      flash[:notice] = 'Classified was successfully updated.'
      redirect_to :action => 'index'
    else
      render :action => "edit"
    end
  end
  
  def destroy
    @classified = Classified.find(params[:id])
    @classified.destroy
    
    redirect_to :action => 'index'
  end
end
