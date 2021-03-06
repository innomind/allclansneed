class ArticleController < ApplicationController

  add_breadcrumb 'Artikel', 'articles_path'
  comment_mce_for
  
  def index
    @articles = Article.paginate
  end

  def show
    @article = Article.find params[:id]
    add_breadcrumb @article.title
  end

  def new
    @article = Article.new
    add_breadcrumb 'Artikel anlegen'
  end

  def create
    @article = Article.new(params[:article])
    if @article.save
      flash[:notice] = "Artikel erfolgreich erstellt"
      redirect_to article_path(@article)
    else
      render :action => "new"
    end
  end

  def edit
    @article = Article.find params[:id]
    add_breadcrumb 'Artikel editieren'
  end

  def update
    @article = Article.find params[:id]
    if @article.update_attributes(params[:article])
      flash[:notice] = "Artikel erfolgreich geändert"
      redirect_to articles_path
    else
      render :action => "edit"
    end
  end

  def destroy
    flash[:notice] = "Artikel gelöscht" if Article.find(params[:id]).destroy 
    redirect_to articles_path
  end
end