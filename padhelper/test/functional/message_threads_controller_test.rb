require 'test_helper'

class MessageThreadsControllerTest < ActionController::TestCase
  setup do
    @message_thread = message_threads(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:message_threads)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create message_thread" do
    assert_difference('MessageThread.count') do
      post :create, message_thread: { thread_helper: @message_thread.thread_helper, thread_user: @message_thread.thread_user, user_id: @message_thread.user_id }
    end

    assert_response 201
  end

  test "should show message_thread" do
    get :show, id: @message_thread
    assert_response :success
  end

  test "should update message_thread" do
    put :update, id: @message_thread, message_thread: { thread_helper: @message_thread.thread_helper, thread_user: @message_thread.thread_user, user_id: @message_thread.user_id }
    assert_response 204
  end

  test "should destroy message_thread" do
    assert_difference('MessageThread.count', -1) do
      delete :destroy, id: @message_thread
    end

    assert_response 204
  end
end
