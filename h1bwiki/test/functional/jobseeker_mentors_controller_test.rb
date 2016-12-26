require 'test_helper'

class JobseekerMentorsControllerTest < ActionController::TestCase
  setup do
    @jobseeker_mentor = jobseeker_mentors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobseeker_mentors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jobseeker_mentor" do
    assert_difference('JobseekerMentor.count') do
      post :create, jobseeker_mentor: { description: @jobseeker_mentor.description, support: @jobseeker_mentor.support, title: @jobseeker_mentor.title }
    end

    assert_redirected_to jobseeker_mentor_path(assigns(:jobseeker_mentor))
  end

  test "should show jobseeker_mentor" do
    get :show, id: @jobseeker_mentor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jobseeker_mentor
    assert_response :success
  end

  test "should update jobseeker_mentor" do
    put :update, id: @jobseeker_mentor, jobseeker_mentor: { description: @jobseeker_mentor.description, support: @jobseeker_mentor.support, title: @jobseeker_mentor.title }
    assert_redirected_to jobseeker_mentor_path(assigns(:jobseeker_mentor))
  end

  test "should destroy jobseeker_mentor" do
    assert_difference('JobseekerMentor.count', -1) do
      delete :destroy, id: @jobseeker_mentor
    end

    assert_redirected_to jobseeker_mentors_path
  end
end
