module CommentHelper
  
  def show_comments model
    render :partial => "comment/index", :locals => { :model => model }
  end
  
  def get_comments model
    debugger
    model.comments.paginate_for_site
  end
end
