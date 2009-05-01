module CommentHelper
  
  def show_comments model
    render :partial => "comment/index", :locals => { :model => model }
  end
  
  def get_comments model  
    model.comments.pages :all, :include => :user
  end
end
