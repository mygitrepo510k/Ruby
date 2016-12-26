require 'test_helper'

describe PasswordResetsController do
  subject {PasswordResetsController.new }
  it("has a create method") { subject.must_respond_to :create }
  it("has a edit method") { subject.must_respond_to :edit }
  it("has a update method") { subject.must_respond_to :update }
  describe "#create" do
    let(:user) { FactoryGirl.build_stubbed(:user) }
    before do
      User.stubs(:find_by_credentials).returns(user)
      user.expects(:deliver_reset_password_instructions!)
      post :create, email: user.email
    end
    it "assigns a user variable" do
      assigns(:user).wont_be_nil
    end
    it "redirects to root_path" do
      response.redirect?.must_equal true
      response.location.must_equal root_url
    end
  end
  describe "#edit" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      User.stubs(:load_from_reset_password_token).returns(user)
      get :edit, id: user.id
    end
    it "assigns a user variable" do
      assigns(:user).wont_be_nil
    end
    it "assigns a token variable" do
      assigns(:token).must_equal user.id.to_s
    end
  end
  describe "#update" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      User.stubs(:load_from_reset_password_token).returns(user)
    end
    describe "success" do
      before do
        put :update, user: {password: 'secret', password_confirmation: 'secret'}, id: user.id
      end
      it "assigns a user variable" do
        assigns(:user).must_equal user
      end
      it "assigns a token variable" do
        assigns(:token).must_equal user.id.to_s
      end
      it "redirects to root path" do
        response.location.must_equal root_url
      end
    end
    describe "failure" do
      it "renders edit when password change fails" do
        User.stubs(:change_password!).returns(:false)
        put :update, user: {password: 'secret', password_confirmation: 'secret'}, id: user.id

      end
    end
  end
end
