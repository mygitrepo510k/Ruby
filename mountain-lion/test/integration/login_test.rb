require 'test_helper'

describe "Login Integration Test" do
  before { visit login_path }
  describe "signup text" do
    it "has a signup text" do
      page.must_have_content("Don't have an account?")
    end
    it "has a signup link" do
      page.find_link('Sign up for free').wont_be_nil
    end
    it "signup link must go to the signup path" do
      click_link('Sign up for free')
      current_path.must_equal(signup_path)
    end
  end
  describe "#login" do
    it "must have a login form with all fields on the page" do
      page.find(".login-form").wont_be_nil
      page.find(".login-form input#username_or_email").wont_be_nil
      page.find(".login-form input#password").wont_be_nil
      page.find(".login-form input#remember[type=checkbox]").wont_be_nil
    end
    it "will login the admin correctly when all fields are entered" do
      user = FactoryGirl.create(:admin)
      user.activate!
      find(".login-form #username_or_email").set(user.username)
      fill_in("password", with: "secret")
      click_button("Login")
      current_path.must_equal admin_root_path
    end
    describe "the user has filled out the required profile questions" do
      it "will login the user correctly when all fields are entered" do
        user = FactoryGirl.create(:user)
        user.activate!
        find(".login-form #username_or_email").set(user.username)
        fill_in("password", with: "secret")
        click_button("Login")
        current_path.must_equal users_path
      end
    end
    describe "the user has not filled out the required profile questions" do
      it "will redirect the user to the profile builder page when they login" do
        user = FactoryGirl.create(:user)
        user.activate!
        find(".login-form #username_or_email").set(user.username)
        fill_in("password", with: "secret")
        click_button("Login")
        current_path.must_equal mandatory_edit_profile_users_path
      end
    end
  end
  describe "#password_recovery" do
    it "must have a password recovery form on the page" do
      page.find('.password-reset-form').wont_be_nil
      page.find('.password-reset-form #username_or_email').wont_be_nil
    end
    it "must send a password recovery e-mail when the form is submitted" do
      user = FactoryGirl.create(:user)
      user.activate!
      find('.password-reset-form #username_or_email').set(user.username)
      click_button('Reset my password!')
      current_path.must_equal(root_path)
      ActionMailer::Base.deliveries.last['to'].to_s.must_equal user.email
    end
  end
end
