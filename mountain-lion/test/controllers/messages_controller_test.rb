require 'test_helper'

describe MessagesController do
  subject { MessagesController.new }
  let(:user) { FactoryGirl.create(:user) }
  before do
    user.activate!
    login_user(user)
  end
  describe "#index" do
    it "works" do
      get :index
      assert_response :redirect
    end
  end

  describe "#inbox" do
    it("has a inbox method") { subject.must_respond_to :inbox }
    it "inbox assigns messages variable and renders index" do
      get :inbox
      assigns(:messages).wont_be_nil
      assigns(:messages).must_respond_to :page
    end
  end
  describe "#sent" do
    it("has a sent method") { subject.must_respond_to :sent }
    it "sent assigns messages variable and renders index" do
      get :sent
      assigns(:messages).wont_be_nil
      assigns(:messages).must_respond_to :page
    end
  end
  describe "#create" do
    it("has a create method") { subject.must_respond_to :create }
    it "creates a message given valid params" do
      message = { message: { subject: "some subject", body: "meh", recipient_id: 1}}
      assert_difference('Message.count', 1) do
        post :create, message
      end
    end
  end
  describe "#show" do
    it("has a show method") { subject.must_respond_to :show }
  end
end
