require 'test_helper'

class InvitesControllerTest < ActionController::TestCase
  setup do
    @invite = invites(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invites)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invite" do
    assert_difference('Invite.count') do
      post :create, invite: { invitee_id: @invite.invitee_id, listing_id: @invite.listing_id, user_id: @invite.user_id }
    end

    assert_response 201
  end

  test "should show invite" do
    get :show, id: @invite
    assert_response :success
  end

  test "should update invite" do
    put :update, id: @invite, invite: { invitee_id: @invite.invitee_id, listing_id: @invite.listing_id, user_id: @invite.user_id }
    assert_response 204
  end

  test "should destroy invite" do
    assert_difference('Invite.count', -1) do
      delete :destroy, id: @invite
    end

    assert_response 204
  end
end
