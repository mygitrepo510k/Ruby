require 'test_helper'

class InvoicesControllerTest < ActionController::TestCase
  setup do
    @invoice = invoices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:invoices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create invoice" do
    assert_difference('Invoice.count') do
      post :create, invoice: { amount: @invoice.amount, from-id: @invoice.from-id, status: @invoice.status, timestamp: @invoice.timestamp, to-id: @invoice.to-id, user_id: @invoice.user_id }
    end

    assert_response 201
  end

  test "should show invoice" do
    get :show, id: @invoice
    assert_response :success
  end

  test "should update invoice" do
    put :update, id: @invoice, invoice: { amount: @invoice.amount, from-id: @invoice.from-id, status: @invoice.status, timestamp: @invoice.timestamp, to-id: @invoice.to-id, user_id: @invoice.user_id }
    assert_response 204
  end

  test "should destroy invoice" do
    assert_difference('Invoice.count', -1) do
      delete :destroy, id: @invoice
    end

    assert_response 204
  end
end
