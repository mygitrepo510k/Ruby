require 'test_helper'

describe "Search Integration Test" do
  include Sorcery::TestHelpers::Rails
  let(:user) { FactoryGirl.create(:user, :user_log => FactoryGirl.create(:user_log)) }
  before do
    user.user_profile = FactoryGirl.create(:user_profile)
    user.activate!
    @paginated_users = (1..21).collect { FactoryGirl.create(:user, :gender=>"F") }
    @paginated_users.each do |pu|
      pu.activate!
    end
    login_integration_user(user)
  end
  describe "user performs simple search" do
    before do
      visit users_path
      click_button('go-search')
    end
    it "should see paginated links" do
      page.must_have_css('nav.pagination')
    end
  end
end
