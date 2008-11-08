require 'test_helper'

class SquadsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:squads)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_squad
    assert_difference('Squad.count') do
      post :create, :squad => { }
    end

    assert_redirected_to squad_path(assigns(:squad))
  end

  def test_should_show_squad
    get :show, :id => squads(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => squads(:one).id
    assert_response :success
  end

  def test_should_update_squad
    put :update, :id => squads(:one).id, :squad => { }
    assert_redirected_to squad_path(assigns(:squad))
  end

  def test_should_destroy_squad
    assert_difference('Squad.count', -1) do
      delete :destroy, :id => squads(:one).id
    end

    assert_redirected_to squads_path
  end
end
