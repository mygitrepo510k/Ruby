require 'test_helper'

class PostMentorsControllerTest < ActionController::TestCase
  setup do
    @post_mentor = post_mentors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_mentors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_mentor" do
    assert_difference('PostMentor.count') do
      post :create, post_mentor: { job_description: @post_mentor.job_description, job_interview: @post_mentor.job_interview, job_title: @post_mentor.job_title }
    end

    assert_redirected_to post_mentor_path(assigns(:post_mentor))
  end

  test "should show post_mentor" do
    get :show, id: @post_mentor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_mentor
    assert_response :success
  end

  test "should update post_mentor" do
    put :update, id: @post_mentor, post_mentor: { job_description: @post_mentor.job_description, job_interview: @post_mentor.job_interview, job_title: @post_mentor.job_title }
    assert_redirected_to post_mentor_path(assigns(:post_mentor))
  end

  test "should destroy post_mentor" do
    assert_difference('PostMentor.count', -1) do
      delete :destroy, id: @post_mentor
    end

    assert_redirected_to post_mentors_path
  end
end
