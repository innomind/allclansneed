class NewsController < ApplicationController
  def index
     @news = News.all
     @tags = News.tag_counts :order => 'count desc'
  end
  
  def show
    @news = News.find(params[:id])
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
                      
                      
    @news.author_id = session['user_id']
    @news.tag_list = @_post['tags']
    
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
  end
  
  def update
    @news = News.find(params[:id])
    if @news.update_attributes(params[:news])
      redirect_to :action => 'index'
    else
      render :action => 'edit'
    end
  end
  
  def findByTag
    @news = News.find_tagged_with(params[:id])
  end
  
  def auto_complete_for_news_tags
    @tags = Tag.find(:all, :conditions => ['name LIKE ?', "#{params[:news][:tags]}%"])
    render :inline => "<%= auto_complete_result(@tags, 'name') %>", :layout => false
  end
  
end