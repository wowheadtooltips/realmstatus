require 'test_helper'

class RealmsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:realms)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create realm" do
    assert_difference('Realm.count') do
      post :create, :realm => { }
    end

    assert_redirected_to realm_path(assigns(:realm))
  end

  test "should show realm" do
    get :show, :id => realms(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => realms(:one).to_param
    assert_response :success
  end

  test "should update realm" do
    put :update, :id => realms(:one).to_param, :realm => { }
    assert_redirected_to realm_path(assigns(:realm))
  end

  test "should destroy realm" do
    assert_difference('Realm.count', -1) do
      delete :destroy, :id => realms(:one).to_param
    end

    assert_redirected_to realms_path
  end
end
