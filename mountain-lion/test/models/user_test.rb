require 'test_helper'

describe User do
  describe "geocoder" do
    subject { FactoryGirl.build(:user)}
    it("must have geo_data attribute") { subject.must_respond_to :geo_data}
    it "geo_data should be of a proper format" do
      subject.geo_data.must_equal '90210, Los Angeles, United States'
    end
    it "should set the latitude and longitude after save" do
      subject.save
      subject.latitude.must_equal(34.052233)
      subject.longitude.must_equal(-118.243682)
    end
  end

  describe "After create" do
    let(:user) { FactoryGirl.create(:user, username: "peropero", email: "peropero@mail.com")}
    it "username and email can't change after signup" do
      user.username = "newusername"
      user.email = "newmail@mail.com"
      user.save
      user.reload
      user.username.must_equal "peropero"
      user.email.must_equal "peropero@mail.com"
    end

    it "must call log_activity with sign_up parameter" do
      user = FactoryGirl.build(:user)
      user.must_send([user, :log_activity, "sign_up"])
      user.save
      user.user_activities.last.activity_type.must_equal "sign_up"
      user.user_activities.last.gender.must_equal user.gender
    end
    it "must have a user profile created" do
      user.user_profile.must_be :present?
    end
  end
  describe "#unread_messages" do
    subject {User.new}
    it("must have an unread messages method") { subject.must_respond_to :unread_messages}
    it("must have a unread_message_count") { subject.must_respond_to :unread_message_count}
    it "unread_message_count must equal the count of unread_messages" do
      subject.unread_message_count.must_equal subject.unread_messages.count
    end
  end
  describe "#profile_views" do
    subject {User.new}
    it("responds to profile visits") { subject.must_respond_to :profile_visits}
  end
  describe "#profile_likes" do
    subject {User.new}
    it("responds to profile likes") { subject.must_respond_to :user_likes}
    it("responds to liked_profiles") { subject.must_respond_to :liked_users}
  end
  describe "#visit_profile" do
    before do
      @user1 = FactoryGirl.create(:user)
      @user1.user_log = UserLog.create(likes_viewed_at: Time.now, views_viewed_at: Time.now)
      @user2 = FactoryGirl.create(:user)
      @user2.user_log = UserLog.create(likes_viewed_at: Time.now, views_viewed_at: Time.now)
    end
    it("has a visit_profile method") {User.new.must_respond_to :visit_profile}
    it "adds a profile visit if it doesn't exist" do
      assert_difference('ProfileVisit.count') do
        @user1.visit_profile(@user2)
      end
    end
    it "doesn't add a new visit if one already exists" do
      @user1.visit_profile(@user2)
      assert_difference('ProfileVisit.count', 0) do
        @user1.visit_profile(@user2)
      end
    end
    it ("responds to #recent_visitors") {User.new.must_respond_to :recent_visitors}
    it "shows the user1 in the recent visitors list" do
      @user1.visit_profile(@user2)
      @user2.recent_visitors.must_equal 1
    end
  end
  describe "#user_log" do
    it("has a user_log relation") { User.new.must_respond_to :user_log}
    it("has a write_log method") { User.new.must_respond_to :write_log}
    describe "#write_log" do
      before do
        @subject = FactoryGirl.create(:user)
        @subject.user_log = UserLog.create(likes_viewed_at: Time.now, views_viewed_at: Time.now)
      end
      it "updates likes_viewed_at with the current time when called with likes" do
        @subject.write_log('likes')
        @subject.user_log.likes_viewed_at.must_be_close_to Time.now, 5.seconds
      end
      it "updates views_viewed_at with the current time when called with views" do
        @subject.write_log('views')
        @subject.user_log.views_viewed_at.must_be_close_to Time.now, 5.seconds
      end
    end
  end
end
