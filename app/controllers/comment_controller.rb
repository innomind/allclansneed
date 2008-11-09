class CommentController < ApplicationController
  uses_tiny_mce
  def index
    
  end
  
  def new
    
  end
  
  def create
    @comment = Comment.new(params[:comment])
    @comment.update_attribute(params[:model].downcase + "_id", params[:id])
    @comment.user = current_user
    if @comment.save
      return if request.xhr?
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def delete
    
  end
end
