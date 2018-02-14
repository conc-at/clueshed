require 'test_helper'

class InterestsControllerTest < ActionController::TestCase
  setup do
    @interest = interests(:one)
    User.first.confirm
    sign_in User.first
  end

  test "should get index" do
    get :index
    assert_response :redirect
    assert_not_nil assigns(:interests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create interest" do
    assert_difference('Interest.count') do
      post :create, params: {interest: {description: @interest.description, title: @interest.title}}
    end

    assert_redirected_to interest_path(assigns(:interest))
  end

  test "should show interest" do
    get :show, params: {id: @interest}
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: {id: @interest}
    assert_response :success
  end

  test "should update interest" do
    patch :update, params: {id: @interest, interest: {description: @interest.description, title: @interest.title}}
    assert_redirected_to interest_path(assigns(:interest))
  end

  test "should destroy interest" do
    assert_difference('Interest.count', -1) do
      delete :destroy, params: {id: @interest}
    end

    assert_redirected_to interests_path
  end
end
