require 'test_helper'

class ApplicantsControllerTest < ActionController::TestCase
  setup do
    @applicant = applicants(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:applicants)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create applicant" do
    assert_difference('Applicant.count') do
      post :create, applicant: { applicant_id: @applicant.applicant_id, move_listing_id: @applicant.move_listing_id, scout_listing_id: @applicant.scout_listing_id }
    end

    assert_response 201
  end

  test "should show applicant" do
    get :show, id: @applicant
    assert_response :success
  end

  test "should update applicant" do
    put :update, id: @applicant, applicant: { applicant_id: @applicant.applicant_id, move_listing_id: @applicant.move_listing_id, scout_listing_id: @applicant.scout_listing_id }
    assert_response 204
  end

  test "should destroy applicant" do
    assert_difference('Applicant.count', -1) do
      delete :destroy, id: @applicant
    end

    assert_response 204
  end
end
