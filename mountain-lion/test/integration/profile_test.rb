require 'test_helper'

describe "Profile Integration Test" do
  include Sorcery::TestHelpers::Rails
  let(:user) { FactoryGirl.create(:user) }
  let(:second_user) {FactoryGirl.create(:user, gender: 'F')}
  before do
    user.user_profile = FactoryGirl.create(:user_profile)
    user.activate!
    second_user.activate!
    login_integration_user(user)
  end
  describe "The lounge" do
    before do
      visit users_path
    end
    it "my profile link must be visible" do
      page.must_have_link('My Profile')
    end
    it "must go to the users profile page when clicked" do
      click_link('My Profile')
      current_path.must_equal user_profile_path
    end
    it "must see the feed from the second user" do
      page.must_have_content(second_user.username)
    end
    it "must go to the second users profile page" do
      click_link("View Profile")
      current_path.must_equal user_path(second_user.username)
      page.must_have_content("About Me...")
      page.must_have_content("I'm Looking For...")
      page.wont_have_content('Update profile')
    end
  end
  describe "#show" do
    it "must see all the User profile data on the page" do
      visit user_profile_path
      page.must_have_content("Le title")
      page.must_have_content("About Me...")
      page.must_have_content("I am a very nice individual")
      page.must_have_content("I'm Looking For...")
      page.must_have_content("Cats")
      page.must_have_link("Update profile")
    end
    it "must have a working user profile link" do
      visit user_profile_path
      click_link("Update profile")
      current_path.must_equal(edit_user_path(user))
    end
  end
  describe "#edit" do
    before do
      visit edit_user_path(user)
    end
    it "must be on the correct page" do
      current_path.must_equal(edit_user_path(user))
    end
    it "must have all of the necessary fields" do
      page.must_have_content('Profile Title')
      page.must_have_content('Profile Description')
      page.must_have_content("I'm Looking For")
      page.must_have_button("Save")
    end
  end
  describe "#mandatory_edit_profile" do
    before do
      RatingCalculator.any_instance.stubs(:recalculate_rating).returns(2)
      @rating = RatingCalculator.new(user).recalculate_rating
      visit mandatory_edit_profile_user_path(user, rating: 2)
    end
    it "must render" do
      save_and_open_page
      page.must_have_content("Please Complete your Online Dating Profile!")
    end
  end
end
