require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should show user" do
    get :show, params: { username: @user.username }
    assert_response :success
  end
end
