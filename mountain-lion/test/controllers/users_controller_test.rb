require 'test_helper'

describe UsersController do
  subject {UsersController.new}
  describe "logged in" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      user.user_log = UserLog.create
      user.activate!
      login_user(user)
    end
    describe "#index" do
      it("must respond to index method") { subject.must_respond_to :index}
      before do
        get :index
      end
      it "must assign a lounge variable" do
        assigns(:lounge).wont_be_nil
      end
    end
    describe "#views" do
      it("responds to views") {subject.must_respond_to :views}
      before do
        get :views
      end
      it "assings a users variable" do
        assigns(:users).wont_be_nil
      end
      it "paginates users" do
        assigns(:users).must_respond_to :page
      end
    end
    describe "#likes" do
      it("responds to likes") {subject.must_respond_to :likes}
      before do
        get :likes
      end
      it "assings a users variable" do
        assigns(:users).wont_be_nil
      end
      it "paginates users" do
        assigns(:users).must_respond_to :page
      end
    end
    describe "#liked" do
      it("responds to liked") {subject.must_respond_to :liked}
      before do
        get :liked
      end
      it "assings a users variable" do
        assigns(:users).wont_be_nil
      end
      it "paginates users" do
        assigns(:users).must_respond_to :page
      end
    end
  end
  describe "#new" do
    it("must respond to new method") { subject.must_respond_to :new}
    it "assigns a user variable" do
      get :new
      assigns(:user).wont_be_nil
    end
  end
  describe "#create" do
    it("must respond to create method") { subject.must_respond_to :create}
  end
  describe "#activate" do
    it("must respond to activate method") { subject.must_respond_to :activate}
    let(:user) { FactoryGirl.create(:user, activation_token: "F8Npt4x4XGTjxbPyh1NT") }
    before do
      login_user(user)
      RatingCalculator.any_instance.stubs(:recalculate_rating).returns(2)
      get :activate, activation_token: user.activation_token 
    end
    it "must redirect to mandatory profile builder page" do
      @rating = RatingCalculator.new(user).recalculate_rating
      assert_redirected_to(mandatory_edit_profile_user_path(action: :mandatory_edit_profile, id: user.id, rating: @rating))
    end
  end
  describe "#password_reset" do
    it("must respond to password_reset method") { subject.must_respond_to :password_reset}
  end
end

