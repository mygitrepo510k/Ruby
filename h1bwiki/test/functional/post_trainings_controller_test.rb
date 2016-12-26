require 'test_helper'

class PostTrainingsControllerTest < ActionController::TestCase
  setup do
    @post_training = post_trainings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_trainings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_training" do
    assert_difference('PostTraining.count') do
      post :create, post_training: { job_accomodation: @post_training.job_accomodation, job_description: @post_training.job_description, job_duration: @post_training.job_duration, job_instruction: @post_training.job_instruction, job_placement: @post_training.job_placement, job_technology: @post_training.job_technology, job_title: @post_training.job_title }
    end

    assert_redirected_to post_training_path(assigns(:post_training))
  end

  test "should show post_training" do
    get :show, id: @post_training
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_training
    assert_response :success
  end

  test "should update post_training" do
    put :update, id: @post_training, post_training: { job_accomodation: @post_training.job_accomodation, job_description: @post_training.job_description, job_duration: @post_training.job_duration, job_instruction: @post_training.job_instruction, job_placement: @post_training.job_placement, job_technology: @post_training.job_technology, job_title: @post_training.job_title }
    assert_redirected_to post_training_path(assigns(:post_training))
  end

  test "should destroy post_training" do
    assert_difference('PostTraining.count', -1) do
      delete :destroy, id: @post_training
    end

    assert_redirected_to post_trainings_path
  end
end
