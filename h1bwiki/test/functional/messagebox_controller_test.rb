require 'test_helper'

class MessageboxControllerTest < ActionController::TestCase
  test "should get inbox" do
    get :inbox
    assert_response :success
  end

  test "should get sent" do
    get :sent
    assert_response :success
  end

  test "should get deleted" do
    get :deleted
    assert_response :success
  end

end
