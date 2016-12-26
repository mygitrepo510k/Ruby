require 'test_helper'

class ScoutListingsControllerTest < ActionController::TestCase
  setup do
    @scout_listing = scout_listings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:scout_listings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create scout_listing" do
    assert_difference('ScoutListing.count') do
      post :create, scout_listing: { baths: @scout_listing.baths, beds: @scout_listing.beds, call: @scout_listing.call, drive: @scout_listing.drive, max-budget: @scout_listing.max-budget, move-in-date: @scout_listing.move-in-date, notes: @scout_listing.notes, tags: @scout_listing.tags, timestamp: @scout_listing.timestamp, user_id: @scout_listing.user_id }
    end

    assert_response 201
  end

  test "should show scout_listing" do
    get :show, id: @scout_listing
    assert_response :success
  end

  test "should update scout_listing" do
    put :update, id: @scout_listing, scout_listing: { baths: @scout_listing.baths, beds: @scout_listing.beds, call: @scout_listing.call, drive: @scout_listing.drive, max-budget: @scout_listing.max-budget, move-in-date: @scout_listing.move-in-date, notes: @scout_listing.notes, tags: @scout_listing.tags, timestamp: @scout_listing.timestamp, user_id: @scout_listing.user_id }
    assert_response 204
  end

  test "should destroy scout_listing" do
    assert_difference('ScoutListing.count', -1) do
      delete :destroy, id: @scout_listing
    end

    assert_response 204
  end
end
