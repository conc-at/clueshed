require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase
  test "should get unprocessable_entity" do
    get :show, code: '422'
    assert_template layout: 'layouts/application'
    assert_response :unprocessable_entity
  end

  test "should get internal_server_error" do
    get :show, code: '500'
    assert_template layout: 'layouts/application'
    assert_response :internal_server_error
  end

  test "should get not_found" do
    get :show, code: '404'
    assert_template layout: 'layouts/application'
    assert_response :not_found
  end

end
