class NewsController < ApplicationController
  
  def index
     @news = News.find_for_site(:all)
     @tags = News.tag_counts (:order => 'count desc', :conditions  => {"site_id"  => $site_id})
  end
  
  def show
    @news = News.find_for_site(params[:id])
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
                      
    @news.user_id = current_user_id
    @news.site_id = $site_id
    @news.tag_list = @_post['tags']
    
    if @news.save
      redirect_to :action => 'index'
    else
      render :action => 'new'
    end
  end
  
  def delete
    @news = News.find_for_site(params[:id])
    @news.destroy
    #redirect_to :action => 'index'
  end
  
  def edit
    @news = News.find_for_site(params[:id])
    @tags = News.tag_counts (:order => 'count desc', :conditions  => {"site_id" => $site_id})
  end
  
  def update
    @_post = params[:news]
    @news = News.find_for_site(params[:id])
    @news.title = @_post['title']
    @news.subtext = @_post['title']
    @news.news = @_post['title']
    @news.tag_list = @_post['tags']
    
    if @news.save
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  
  def findByTag
    @news = News.find_tagged_with(params[:id], :conditions  => {"site_id"  => $site_id})
  end
  
  def auto_complete_for_news_tags
    #autocomplete funktioniert nicht wenn mehrere, durch komma getrennte, tags in der eingabemaske sind
    #@tags = Tag.find(:all, :conditions => ['name LIKE :nt AND site_id = :site_id', {:nt => params[:news][:tags]+'%', :site_id  => $site_id}])
    @tags = Tag.find(:all, :conditions => ['name LIKE ?', "#{params[:news][:tags]}%"])
    render :inline => "<%= auto_complete_result(@tags, 'name') %>", :layout => false
  end
end