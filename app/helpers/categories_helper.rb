module CategoriesHelper
  def categories_link controller, link_text = "Kategorien bearbeiten", options = {} 
    link_to image_tag("folder.png") + " " + link_text, category_path(controller) if @user.has_right_for? controller.underscore unless @user.nil?
  end
end