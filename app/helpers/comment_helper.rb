module CommentHelper
  
  def show_comments model
    render :partial => "comment/index", :locals => { :model => model }
  end
  
  def get_comments model
    model.comments.paginate_for_site
  end
end
