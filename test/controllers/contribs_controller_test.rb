require 'test_helper'

class ContribsControllerTest < ActionController::TestCase
  setup do
    @contrib = contribs(:one)
    User.first.confirm
    sign_in User.first
  end

  test "should get index" do
    get :index
    assert_response :redirect
    assert_not_nil assigns(:contribs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contrib" do
    assert_difference('Contrib.count') do
      post :create, params: {contrib: {description: @contrib.description, title: @contrib.title}}
    end

    assert_redirected_to contrib_path(assigns(:contrib))
  end

  test "should show contrib" do
    get :show, params: {id: @contrib}
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: {id: @contrib}
    assert_response :success
  end

  test "should update contrib" do
    patch :update, params: {id: @contrib, contrib: {description: @contrib.description, title: @contrib.title}}
    assert_redirected_to contrib_path(assigns(:contrib))
  end

  test "should destroy contrib" do
    assert_difference('Contrib.count', -1) do
      delete :destroy, params: {id: @contrib}
    end

    assert_redirected_to contribs_path
  end
end
