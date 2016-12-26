require 'test_helper'

describe "Upgrade to Premium Integration Test" do
  include Sorcery::TestHelpers::Rails
  let(:free_user) { FactoryGirl.create(:user, :user_log => FactoryGirl.create(:user_log)) }
  before do
    free_user.user_profile = FactoryGirl.create(:user_profile)
    free_user.activate!
    @paginated_users = (1..66).collect { FactoryGirl.create(:user, :gender=>"F") }
    @paginated_users.each do |pu|
      pu.activate!
    end
    login_integration_user(free_user)
    visit users_path
  end
  describe "upgrade user and store customer email in Netbilling service" do
    #pending
  end
  it "should be that a free user can only view 3 pages on lounge" do
    #pending
  end
  it "should be that free user can only view 3 pages on search" do
    #pending
  end
end