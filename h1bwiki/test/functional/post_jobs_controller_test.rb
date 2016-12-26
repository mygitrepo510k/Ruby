require 'test_helper'

class PostJobsControllerTest < ActionController::TestCase
  setup do
    @post_job = post_jobs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:post_jobs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create post_job" do
    assert_difference('PostJob.count') do
      post :create, post_job: { description: @post_job.description, job_title: @post_job.job_title, job_type: @post_job.job_type }
    end

    assert_redirected_to post_job_path(assigns(:post_job))
  end

  test "should show post_job" do
    get :show, id: @post_job
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @post_job
    assert_response :success
  end

  test "should update post_job" do
    put :update, id: @post_job, post_job: { description: @post_job.description, job_title: @post_job.job_title, job_type: @post_job.job_type }
    assert_redirected_to post_job_path(assigns(:post_job))
  end

  test "should destroy post_job" do
    assert_difference('PostJob.count', -1) do
      delete :destroy, id: @post_job
    end

    assert_redirected_to post_jobs_path
  end
end
