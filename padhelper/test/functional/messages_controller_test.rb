require 'test_helper'

class MessagesControllerTest < ActionController::TestCase
  setup do
    @message = messages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:messages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message" do
    assert_difference('Message.count') do
      post :create, message: { message_thread_id: @message.message_thread_id, msg-content: @message.msg-content, sender: @message.sender, timestamp: @message.timestamp }
    end

    assert_response 201
  end

  test "should show message" do
    get :show, id: @message
    assert_response :success
  end

  test "should update message" do
    put :update, id: @message, message: { message_thread_id: @message.message_thread_id, msg-content: @message.msg-content, sender: @message.sender, timestamp: @message.timestamp }
    assert_response 204
  end

  test "should destroy message" do
    assert_difference('Message.count', -1) do
      delete :destroy, id: @message
    end

    assert_response 204
  end
end
