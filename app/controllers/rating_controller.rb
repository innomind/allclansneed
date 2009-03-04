class RatingController < ApplicationController
  def rate
    begin
      @asset = eval(params[:asset_name]).find params[:id]
      Rating.delete_all(["rateable_type = 'Article' AND rateable_id = ? AND user_id = ?", @asset.id, current_user.id])
      @asset.add_rating Rating.new(:rating => params[:rating], :user_id => current_user.id)
    rescue NameError
      render :layout => true, :text => "ups" and return
    end
  end
end

