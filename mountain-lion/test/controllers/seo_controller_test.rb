require 'test_helper'

class SeoControllerTest < ActionController::TestCase
  test "should get landing" do
    get :landing
    assert_response :success
  end

  test "should get men" do
    get :men
    assert_response :success
  end

  test "should get women" do
    get :women
    assert_response :success
  end

end
