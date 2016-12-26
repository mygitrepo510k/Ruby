require 'test_helper'

class Settings::PaymentControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

end
