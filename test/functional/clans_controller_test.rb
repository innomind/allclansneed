require 'test_helper'

class ClansControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:clans)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_clan
    assert_difference('Clan.count') do
      post :create, :clan => { }
    end

    assert_redirected_to clan_path(assigns(:clan))
  end

  def test_should_show_clan
    get :show, :id => clans(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => clans(:one).id
    assert_response :success
  end

  def test_should_update_clan
    put :update, :id => clans(:one).id, :clan => { }
    assert_redirected_to clan_path(assigns(:clan))
  end

  def test_should_destroy_clan
    assert_difference('Clan.count', -1) do
      delete :destroy, :id => clans(:one).id
    end

    assert_redirected_to clans_path
  end
end
