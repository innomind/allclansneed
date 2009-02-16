class NewsController < ApplicationController
  #ACTION_LEVELS = {:new => LEVEL_SITE_ADMIN}
  add_breadcrumb 'News', 'news_path'
  before_filter :init_news, :only => [:show, :delete, :edit, :update]
  
  def index
    @news = News.find_for_site(:all)
    @tags = News.tag_counts(:order => 'count desc', :conditions  => {:site_id  => current_site_id})
  end
  
  def show
  end
  
  def new
    @news = News.new
    @tags = News.tag_counts :order => 'count desc'
  end
  
  def create
    @_post = params[:news]
    
    @news = News.new( :title => @_post['title'],
                      :subtext => @_post['subtext'],
                      :news => @_post['news'])
                      
    @news.user = current_user
    @news.site = current_site
    @news.tag_list = @_post['tags']
    
    if @news.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end
  
  def delete
    @news.destroy
    #redirect_to :action => 'index'
  end
  
  def edit
    @tags = News.tag_counts(:order => 'count desc', :conditions  => {:site_id  => current_site_id})
  end
  
  def update
    #@_post = params[:news]
    #@news.title = @_post['title']
    #@news.subtext = @_post['title']
    #@news.news = @_post['title']
    #@news.tag_list = @_post['tags']
    @news.update_attributes(params[:news])
    if @news.save
      redirect_to :action => 'index'
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
    @news = News.find_for_site(params[:id])
    add_breadcrumb @news.title, ''
  end
end