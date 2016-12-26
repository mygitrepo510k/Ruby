require 'test_helper'

describe "Lounge Appearance Integration Test" do
  include Sorcery::TestHelpers::Rails
  let(:user) { FactoryGirl.create(:user, :user_log => FactoryGirl.create(:user_log), :user_activity=>FactoryGirl.create(:user_activity)) }
  before do
    user.user_profile = FactoryGirl.create(:user_profile)
    user.activate!
    #create in reverse order to account for order by updated_at DESC
    @rated_users = 5.downto(1).collect { |x| FactoryGirl.create(:user, :username=>"username#{x}",:gender=>"F", :rating=>x) }
    @rated_users.each do |ru|
      ru.activate!
    end
    @rated_users << FactoryGirl.create(:user, :username=>"username3#{@rated_users.length+1}",:gender=>"F", :rating=>3, :user_activity=>FactoryGirl.create(:user_activity))
    @rated_users[@rated_users.length-1].activate!
    @rated_users[@rated_users.length-1].log_activity('profile_update')
    login_integration_user(user)
  end
  describe "the lounge (or users index view)" do
    it "should be sorted from most recent to least recent activity" do
      visit users_path
      n = (page.body =~ /username3#{@rated_users.length}.+username1.+username2.+username3.+username4.+username5/m)
      assert(n!=nil,"user names are not displaying in order of most recent activity, desc")
    end
  end
end