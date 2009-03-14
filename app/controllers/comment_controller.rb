class CommentController < ApplicationController
  #uses_tiny_mce

  def create
    @comment = Comment.new(params[:comment])
    @comment.commentable_id = params[:id]
    @comment.commentable_type = params[:model]
    if @comment.save
      return if request.xhr?
    end
  end
  
end
