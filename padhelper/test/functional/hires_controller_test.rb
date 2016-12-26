require 'test_helper'

class HiresControllerTest < ActionController::TestCase
  setup do
    @hire = hires(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:hires)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create hire" do
    assert_difference('Hire.count') do
      post :create, hire: { hired_helper_id: @hire.hired_helper_id, hiring_user_id: @hire.hiring_user_id, user_id: @hire.user_id }
    end

    assert_response 201
  end

  test "should show hire" do
    get :show, id: @hire
    assert_response :success
  end

  test "should update hire" do
    put :update, id: @hire, hire: { hired_helper_id: @hire.hired_helper_id, hiring_user_id: @hire.hiring_user_id, user_id: @hire.user_id }
    assert_response 204
  end

  test "should destroy hire" do
    assert_difference('Hire.count', -1) do
      delete :destroy, id: @hire
    end

    assert_response 204
  end
end
