class ClassifiedController < ApplicationController
  
  def list
#    @classifieds = Classified.find(:all)
     # einzige umsetzung der pageid. aber analog für alles andere einsetzbar
     @classifieds = Page.find(params[:page_id]).classifieds
  end

  def show
    @classified = Classified.find(params[:id])
  end

  def new
    @classified = Classified.new
    @categories = Category.find(:all)
  end
  
  def create
    @classified = Classified.new(params[:classified])
    # pageid wird einfach angehängt und unschön aus dem parameter geholt
    # besser wäre eine variable im ApplicationController
    @classified.page_id = params[:page_id]
    @categories = Category.find(:all)
    if @classified.save
      redirect_to :action => 'list'
    else
      render :action => 'new'
    end
  end
  
  def edit
    @classified = Classified.find(params[:id])
    @categories = Category.find(:all)
  end
  
  def update
    @classified = Classified.find(params[:id])
    @categories = Category.find(:all)
    if @classified.update_attributes(params[:classified])
      redirect_to :action => 'show', :id => @classified
    else
      render :action => 'edit'
    end
  end
  
  def delete
    Classified.find(params[:id]).destroy
    redirect_to :action => 'list'
  end
  
  def search
    @classifieds = Classified.find(:all,
                      :conditions => ["lower(title) like ?",
                                        "%" + params[:search].downcase + "%"])
    #if params[:search].to_s.size < 1
    #    render :nothing => true
    #else
      if @classifieds.size > 0
        render :partial => 'classified', :collection => @classifieds
      else
        render :text => "<li>No results found</li>", :layout => false
      end
    #end
  end
  
end
