module CommentHelper
  
  def show_comments model
    render :partial => "comment/index", :locals => { :model => model }
  end
  
  def get_comments model  
    model.comments.page_for_site :all, :conditions => {:user_id => 1}
  end
end
