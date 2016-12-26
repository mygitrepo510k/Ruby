require 'test_helper'
=begin
describe UserPhotosController do
  subject { UserPhotosController.new }
  let(:user) {FactoryGirl.create(:user)}
  let(:user_photo) { FactoryGirl.build_stubbed(:user_photo, user_id: user.id, approved: true) }
  before do
    user.stubs(:recent_visitors).returns(0)
    user.activate!
    login_user(user)
  end
  describe "#index" do
    it("has a #index method") { subject.must_respond_to(:index)}
    before do
      User.stubs(:find).returns(user)
      get :index, user_id: user.id
    end
    it "assigns a user_photos collection" do
      assigns(:user_photos).wont_be_nil
    end
    it "assigns only photos from the current user" do
      FactoryGirl.create(:user_photo, user: user, approved: true )
      assigns(:user_photos).size.must_be :>, 0
    end
    it "assigns a user variable(this one is general for all methods)" do
      assigns(:user).must_equal user
    end
  end
  describe "#show" do
    let(:user) {FactoryGirl.create(:user)}
    it("has a #show method") {subject.must_respond_to :show}
    it "shows the created user's photo" do
      user_photo = FactoryGirl.create(:user_photo, user: user, approved: true )
      get :show, user_id: user.id, id: user_photo.id
      assigns(:user_photo).must_equal user_photo
    end
    it "won't show a photo if it isn't approved" do
      user_photo = FactoryGirl.create(:user_photo, user: user)
      get :show, user_id: user.id, id: user_photo.id
      assigns(:user_photo).must_be_nil
      assert_redirected_to user_user_photos_url(user)
    end
  end
  describe "#destroy" do
    it("has a destroy method"){ subject.must_respond_to(:destroy)}
    let(:user_photo) {FactoryGirl.create(:user_photo, user: user, approved: true )}
    it "destroys the photo" do
      User.stubs(:find).returns(user)
      user_photo
      assert_difference('UserPhoto.count', -1) do
        delete :destroy, user_id: user.id, id: user_photo.id
      end
      assert_redirected_to user_user_photos_url(user)
    end
    it "can't destroy someone elses photo" do
      user2 = FactoryGirl.build_stubbed(:user)
      photo = FactoryGirl.create(:user_photo, user: user2, approved: true )
      User.stubs(:find).returns(user2)
      assert_difference('UserPhoto.count', 0) do
        delete :destroy, user_id: user2.id, id: photo.id
      end
      assert_redirected_to user_user_photos_url(user2)
    end
  end
end
=end
