module RatingHelper
  def rating_for model
    content_tag :div, :id => "star-ratings-block" do
      render :partial => "rating/rating", :locals => { :asset => model }
    end
  end
end