require 'test_helper'

describe "AdminUsers Integration Test" do
  let(:admin) { FactoryGirl.create(:admin) }
  let(:user) { FactoryGirl.create(:user) }
  setup do
    user
    admin.activate!
    login_integration_user(admin)
  end
  teardown do
    logout_integration_user(admin)
  end
  describe "all users" do
    before do
      visit admin_users_path
    end
    it "must have a good response" do
      response_status.must_equal 200
    end
    it "must have All users in the header" do
      page.must_have_content("Users")
    end
    it "must show a created user on the page" do
      page.must_have_content(user.username)
    end
  end
  describe "one user" do
    before do
      visit admin_user_path(user)
    end
    it "must have a 200 response" do
      response_status.must_equal 200
    end
    it "must have a user username in the page" do
      page.must_have_content(user.username)
    end
    it "it must be a good path" do
      current_path.must_equal admin_user_path(user)
    end
  end
  it "deletes the user" do
    user = FactoryGirl.create(:user)
    visit admin_users_path
    page.must_have_content(user.username)
    assert_difference('User.count', -1) do
      page.find("a[href='#{admin_user_path(user)}'][data-method=delete]").click
    end
    current_path.must_equal admin_users_path
    page.wont_have_content(user.username)
  end
end
