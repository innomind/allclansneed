require 'test_helper'

class TestingsControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:testings)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_testings
    assert_difference('Testings.count') do
      post :create, :testings => { }
    end

    assert_redirected_to testings_path(assigns(:testings))
  end

  def test_should_show_testings
    get :show, :id => testings(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => testings(:one).id
    assert_response :success
  end

  def test_should_update_testings
    put :update, :id => testings(:one).id, :testings => { }
    assert_redirected_to testings_path(assigns(:testings))
  end

  def test_should_destroy_testings
    assert_difference('Testings.count', -1) do
      delete :destroy, :id => testings(:one).id
    end

    assert_redirected_to testings_path
  end
end
