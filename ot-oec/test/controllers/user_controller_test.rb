require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "should get confirm" do
    get :confirm
    assert_response :success
  end

end
