require 'test_helper'

describe "Admin::UsersController" do
  setup do
    admin = FactoryGirl.build_stubbed(:admin)
    admin.activate!
    login_user(admin)
  end
  describe "#index" do
    before { get :index }
    it "assigns users instance variable" do
      assigns(:users).wont_be_nil
    end
    it "assigns users with pagination" do
      assigns(:users).must_respond_to(:page)
    end
  end
  describe "#new" do
    before { get :new }
    it "assigns a new user variable" do
      assigns(:user).wont_be_nil
    end
    it "assigned user variable must be an Admin class" do
      assigns(:user).must_be_instance_of User
    end
  end
end
