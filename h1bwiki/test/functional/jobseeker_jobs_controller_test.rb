require 'test_helper'

class JobseekerJobsControllerTest < ActionController::TestCase
  setup do
    @jobseeker_job = jobseeker_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:jobseeker_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create jobseeker_job" do
    assert_difference('JobseekerJob.count') do
      post :create, jobseeker_job: { description: @jobseeker_job.description, status: @jobseeker_job.status, title: @jobseeker_job.title, transfer: @jobseeker_job.transfer }
    end

    assert_redirected_to jobseeker_job_path(assigns(:jobseeker_job))
  end

  test "should show jobseeker_job" do
    get :show, id: @jobseeker_job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @jobseeker_job
    assert_response :success
  end

  test "should update jobseeker_job" do
    put :update, id: @jobseeker_job, jobseeker_job: { description: @jobseeker_job.description, status: @jobseeker_job.status, title: @jobseeker_job.title, transfer: @jobseeker_job.transfer }
    assert_redirected_to jobseeker_job_path(assigns(:jobseeker_job))
  end

  test "should destroy jobseeker_job" do
    assert_difference('JobseekerJob.count', -1) do
      delete :destroy, id: @jobseeker_job
    end

    assert_redirected_to jobseeker_jobs_path
  end
end
