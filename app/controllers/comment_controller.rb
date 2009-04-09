class CommentController < ApplicationController
  def create
    params[:comment].delete(:intern) if params[:comment][:intern].empty?
    @comment = Comment.new(params[:comment])
    @comment.commentable_id = params[:id]
    @comment.commentable_type = params[:model]
    if @comment.save
      flash[:notice] = "Kommentar erstellt"
      return if request.xhr?
    end
  end
end