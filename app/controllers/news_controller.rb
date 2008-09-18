class NewsController < ApplicationController
  def index
    @categories = NewsCategory.all
    @news = News.all
  end
  
  def show
    @news = News.find(params[:id])
  end
  
  def new
    @news = News.new
    @news_categories = NewsCategory.all

  end
  
  def create
    @news = News.new(params[:news])
    @news.author_id = session['user_id']
    
    if @news.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end
  
  def delete
    @news = News.find(params[:id])
    @news.destroy
    #redirect_to :action => 'index'
  end
  
  def edit
    @news = News.find(params[:id])
    @news_categories = NewsCategory.all
  end
  
  def update
    @news = News.find(params[:id])
    if @news.update_attributes(params[:news])
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
end