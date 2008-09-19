class NewsCommentController < ApplicationController
  
  def create
    @comment = NewsComment.new(params[:news_comment])
    @comment.news_id = params[:id]
    @comment.author_id = current_user_id
    
    @comment.save
    redirect_to :controller  => 'news', :action => 'index'
  end
end
