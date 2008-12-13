class CommentController < ApplicationController
  #uses_tiny_mce

  def create
    @comment = Comment.new(params[:comment])
    @comment.commentable_id = params[:id]
    @comment.commentable_type = params[:model]
    #@comment.update_attribute(params[:model].downcase + "_id", params[:id])
    @comment.site = current_site
    @comment.user = current_user
    if @comment.save
      return if request.xhr?
    end
  end
  
end
