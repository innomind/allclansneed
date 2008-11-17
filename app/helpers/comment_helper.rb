module CommentHelper
  
  def show_comments model
    render :partial => "comment/index", :locals => { :model => model }
  end
  
  def get_comments model
    model.comments.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => @per_page)
  end
end
