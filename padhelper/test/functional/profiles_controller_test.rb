require 'test_helper'

class ProfilesControllerTest < ActionController::TestCase
  setup do
    @profile = profiles(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profiles)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile" do
    assert_difference('Profile.count') do
      post :create, profile: { address: @profile.address, city: @profile.city, completed-jobs: @profile.completed-jobs, email: @profile.email, helpers-hired: @profile.helpers-hired, hourly-rate: @profile.hourly-rate, job-applications: @profile.job-applications, listings-posted: @profile.listings-posted, name: @profile.name, paypal-email: @profile.paypal-email, portrait: @profile.portrait, rating: @profile.rating, state: @profile.state, user_id: @profile.user_id, zip: @profile.zip }
    end

    assert_response 201
  end

  test "should show profile" do
    get :show, id: @profile
    assert_response :success
  end

  test "should update profile" do
    put :update, id: @profile, profile: { address: @profile.address, city: @profile.city, completed-jobs: @profile.completed-jobs, email: @profile.email, helpers-hired: @profile.helpers-hired, hourly-rate: @profile.hourly-rate, job-applications: @profile.job-applications, listings-posted: @profile.listings-posted, name: @profile.name, paypal-email: @profile.paypal-email, portrait: @profile.portrait, rating: @profile.rating, state: @profile.state, user_id: @profile.user_id, zip: @profile.zip }
    assert_response 204
  end

  test "should destroy profile" do
    assert_difference('Profile.count', -1) do
      delete :destroy, id: @profile
    end

    assert_response 204
  end
end
