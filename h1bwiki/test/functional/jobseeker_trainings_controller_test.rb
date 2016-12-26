require 'test_helper'

class JobseekerTrainingsControllerTest < ActionController::TestCase
  setup do
    @jobseeker_training = jobseeker_trainings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobseeker_trainings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jobseeker_training" do
    assert_difference('JobseekerTraining.count') do
      post :create, jobseeker_training: { accomodation: @jobseeker_training.accomodation, description: @jobseeker_training.description, instruction_mod: @jobseeker_training.instruction_mod, status: @jobseeker_training.status, technology: @jobseeker_training.technology, title: @jobseeker_training.title, transfer: @jobseeker_training.transfer }
    end

    assert_redirected_to jobseeker_training_path(assigns(:jobseeker_training))
  end

  test "should show jobseeker_training" do
    get :show, id: @jobseeker_training
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jobseeker_training
    assert_response :success
  end

  test "should update jobseeker_training" do
    put :update, id: @jobseeker_training, jobseeker_training: { accomodation: @jobseeker_training.accomodation, description: @jobseeker_training.description, instruction_mod: @jobseeker_training.instruction_mod, status: @jobseeker_training.status, technology: @jobseeker_training.technology, title: @jobseeker_training.title, transfer: @jobseeker_training.transfer }
    assert_redirected_to jobseeker_training_path(assigns(:jobseeker_training))
  end

  test "should destroy jobseeker_training" do
    assert_difference('JobseekerTraining.count', -1) do
      delete :destroy, id: @jobseeker_training
    end

    assert_redirected_to jobseeker_trainings_path
  end
end
