module CommentHelper
  def get_comments model
    model.comments.paginate(:page => params[:page], :order => 'created_at DESC', :per_page => @per_page)
  end
end
