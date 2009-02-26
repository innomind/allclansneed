class NewsController < ApplicationController
  #ACTION_LEVELS = {:new => LEVEL_SITE_ADMIN}
  add_breadcrumb 'News', 'news_path'
  before_filter :init_news, :only => [:show, :destroy, :edit, :update]
  
  def index
    @news = News.paginate(:all)
    @tags = News.tag_counts(:order => 'count desc', :conditions  => {:site_id  => current_site.id})
  end
  
  def show
  end
  
  def new
    add_breadcrumb 'News erstellen'
    @news = News.new
    @tags = News.tag_counts :order => 'count desc', :conditions  => {:site_id  => current_site.id}
  end
  
  def create
    tags = params[:news].delete(:tags)
    @news = News.new params[:news]          
    @news.tag_list = tags
    
    if @news.save
      flash[:notice] = "News erstellt"
      redirect_to news_path
    else
      render :action => 'new'
    end
  end
  
  def destroy
    @news.destroy
    flash[:notice] = "News gelöscht"
    redirect_to news_path
  end
  
  def edit
    @tags = News.tag_counts(:order => 'count desc', :conditions  => {:site_id  => current_site_id})
  end
  
  def update
    tags = params[:news].delete(:tags)
    @news.update_attributes(params[:news])
    @news.tag_list = tags
    if @news.save
      flash[:notice] = "News erfolgreich bearbeitet"
      redirect_to news_path
    else
      render :action => 'edit'
    end
  end
  
  def findByTag
    @news = News.find_tagged_with(params[:id], :conditions  => {:site_id  => current_site_id})
  end
  
  def auto_complete_for_news_tags
    #autocomplete funktioniert nicht wenn mehrere, durch komma getrennte, tags in der eingabemaske sind
    #@tags = Tag.find(:all, :conditions => ['name LIKE :nt AND site_id = :site_id', {:nt => params[:news][:tags]+'%', :site_id  => $site_id}])
    @tags = Tag.find(:all, :conditions => ['name LIKE ?', "#{params[:news][:tags]}%"])    
    render :inline => "<%= auto_complete_result(@tags, 'name') %>", :layout => false
  end
  
  private
  
  def init_news
    @news = News.find(params[:id])
    add_breadcrumb @news.title
  end
end