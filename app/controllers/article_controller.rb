class ArticleController < ApplicationController

 CONTROLLER_ACCESS = COMPONENT_RIGHT_OWNER

  ACTION_ACCESS_TYPES= {
    :index => PUBLIC,
    :show => PUBLIC
  }
  add_breadcrumb 'Article', 'Article_Path'

  def index

  end

  def show

  end

  def create

  end

  def delete

  end

  def edit

  end

  def update

  end

end
