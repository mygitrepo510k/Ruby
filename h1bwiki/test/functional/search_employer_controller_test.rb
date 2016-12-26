require 'test_helper'

class SearchEmployerControllerTest < ActionController::TestCase
  test "should get h1bemployer" do
    get :h1bemployer
    assert_response :success
  end

end
