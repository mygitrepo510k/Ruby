require 'test_helper'

class HelperArchivesControllerTest < ActionController::TestCase
  setup do
    @helper_archive = helper_archives(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:helper_archives)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create helper_archive" do
    assert_difference('HelperArchive.count') do
      post :create, helper_archive: { user_id: @helper_archive.user_id }
    end

    assert_response 201
  end

  test "should show helper_archive" do
    get :show, id: @helper_archive
    assert_response :success
  end

  test "should update helper_archive" do
    put :update, id: @helper_archive, helper_archive: { user_id: @helper_archive.user_id }
    assert_response 204
  end

  test "should destroy helper_archive" do
    assert_difference('HelperArchive.count', -1) do
      delete :destroy, id: @helper_archive
    end

    assert_response 204
  end
end
