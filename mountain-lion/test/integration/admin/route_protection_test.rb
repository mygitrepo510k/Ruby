require 'test_helper'

describe "RouteProtection Integration Test" do
  let(:paths) do
    [admin_users_path, admin_flirts_path,
      admin_profile_sections_path, admin_root_path,
      admin_profile_questions_path]
  end
  describe "As an admin" do
    let(:admin) { FactoryGirl.create(:admin)}
    setup do
      admin.activate!
      login_integration_user(admin)
    end
    teardown do
      logout_integration_user(admin)
    end
    it "must be able to visit all top paths" do
      paths.each do |path|
        visit path
        current_path.must_equal path
      end
    end
  end
  describe "As an regular user" do
    let(:user) { FactoryGirl.create(:user)}
    setup do
      user.activate!
      login_integration_user(user)
    end
    teardown do
      logout_integration_user(user)
    end
    it "will be redirected from admin paths" do
      paths.each do |path|
        visit path
        current_path.must_equal users_path
      end
    end
  end
  describe "As an unauthenticated user" do
    it "will be redirected from admin paths" do
      paths.each do |path|
        visit path
        current_path.must_equal root_path
      end
    end
  end
end
