require 'test_helper'

class MoveListingsControllerTest < ActionController::TestCase
  setup do
    @move_listing = move_listings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:move_listings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create move_listing" do
    assert_difference('MoveListing.count') do
      post :create, move_listing: { end-address: @move_listing.end-address, move-type: @move_listing.move-type, notes: @move_listing.notes, packing: @move_listing.packing, start-address: @move_listing.start-address, timestamp: @move_listing.timestamp, user_id: @move_listing.user_id }
    end

    assert_response 201
  end

  test "should show move_listing" do
    get :show, id: @move_listing
    assert_response :success
  end

  test "should update move_listing" do
    put :update, id: @move_listing, move_listing: { end-address: @move_listing.end-address, move-type: @move_listing.move-type, notes: @move_listing.notes, packing: @move_listing.packing, start-address: @move_listing.start-address, timestamp: @move_listing.timestamp, user_id: @move_listing.user_id }
    assert_response 204
  end

  test "should destroy move_listing" do
    assert_difference('MoveListing.count', -1) do
      delete :destroy, id: @move_listing
    end

    assert_response 204
  end
end
