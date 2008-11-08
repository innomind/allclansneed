module CommentHelper
  def get_comments model
    model.comments.find(:all)
  end
end
