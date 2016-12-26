require 'test_helper'

describe UserMailer do
  subject { UserMailer }
  it("has a activation_needed_email method") { subject.must_respond_to :activation_needed_email }
  it("has a activation_success_email method") { subject.must_respond_to :activation_success_email }
  it("has a reset_password_email method") { subject.must_respond_to :reset_password_email }
  it("has a message_received_email method") { subject.must_respond_to :message_received_email }
  it("has a flirt_received_email method") { subject.must_respond_to :flirt_received_email }
  it("has a profile_like_email method") { subject.must_respond_to :profile_like_email }
  it("has a profile_views_email method") { subject.must_respond_to :profile_views_email }
  it("has a new_users_email method") { subject.must_respond_to :new_users_email }
  let(:user) do
    user = MiniTest::Mock.new
    user.expect(:email, "user@example.com")
    user.expect(:username, "SomeUser")
    user.expect(:id, 1)
    user.expect(:activation_token, "dsadsadfafa")
    user.expect(:activation_token, "dsadsadfafa")
    user.expect(:reset_password_token, "dsadsadfafa")
    user.expect(:unsubscribe_token, "unsubscribe_token")
  end
  describe "#activation_needed_email" do
    before do
      @mail = UserMailer.activation_needed_email(user).deliver
    end
    it "should send an email" do
      ActionMailer::Base.deliveries.last.must_equal(@mail)
    end
    it "should assign a correct email" do
      @mail[:to].to_s.must_equal("user@example.com")
    end
    it "should have a subject" do
      @mail[:subject].to_s.wont_be :empty?
    end
    it "should include auth token in the body" do
      @mail.to_s.must_match(/dsadsadfafa/)
    end
    it "should have an unsubscribe token in the body" do
      @mail.to_s.must_match /users\/unsubscribe_token\/unsubscribe/
    end
  end
  describe "activation_success_email" do
    before do
      @mail = UserMailer.activation_success_email(user).deliver
    end
    it "should send a correct email" do
      ActionMailer::Base.deliveries.last.must_equal(@mail)
    end
    it "should assign a correct email" do
      @mail[:to].to_s.must_equal("user@example.com")
    end
    it "should have a subject" do
      @mail[:subject].to_s.must_equal I18n.t('emails.activation_success.subject')
    end
    it "should have an unsubscribe token in the body" do
      @mail.to_s.must_match /users\/unsubscribe_token\/unsubscribe/
    end
  end
  describe "#reset_password_email" do
    before do
      @mail = UserMailer.reset_password_email(user).deliver
    end
    it "should send a correct email" do
      ActionMailer::Base.deliveries.last.must_equal(@mail)
    end
    it "should assign a correct email" do
      @mail[:to].to_s.must_equal("user@example.com")
    end
    it "should have a subject" do
      @mail[:subject].to_s.must_equal I18n.t('emails.password_reset.subject')
    end
    it "should have an unsubscribe token in the body" do
      @mail.to_s.must_match /users\/unsubscribe_token\/unsubscribe/
    end
  end
  describe "#message_received_email" do
    before do
      setting = MiniTest::Mock.new
      setting.expect(:messages_email, true)
      user = MiniTest::Mock.new
      user.expect(:unsubscribe_token, 'unsubscribe_token')
      user.expect(:setting, setting)
      user.expect(:username, 'uhlala')
      user.expect(:email, 'user@example.com')
      sender = MiniTest::Mock.new
      sender.expect(:username, 'uhlala')
      @message = MiniTest::Mock.new
      @message.expect(:subject, 'Some Subject')
      @message.expect(:body, 'Some Subject')
      @message.expect(:recipient, user)
      @message.expect(:recipient, user)
      @message.expect(:recipient, user)
      @message.expect(:recipient, user)
      @message.expect(:sender, sender)
      @mail = UserMailer.message_received_email(@message).deliver
    end
    it "should send a correct email" do
      ActionMailer::Base.deliveries.last.must_equal(@mail)
    end
    it "should assign a correct email" do
      @mail[:to].to_s.must_equal("user@example.com")
    end
    it "should have a subject" do
      @mail[:subject].to_s.must_equal 'You have a new message at HyeDating.com'
    end
    it "should have an unsubscribe token in the body" do
      @mail.to_s.must_match /users\/unsubscribe_token\/unsubscribe/
    end
  end
  describe "#flirt_received_email" do
    before do
      setting = MiniTest::Mock.new
      setting.expect(:flirts_email, true)
      user = MiniTest::Mock.new
      user.expect(:unsubscribe_token, 'unsubscribe_token')
      user.expect(:setting, setting)
      user.expect(:username, 'uhlala')
      user.expect(:email, 'user@example.com')
      sender = MiniTest::Mock.new
      sender.expect(:username, 'uhlala')
      @message = MiniTest::Mock.new
      @message.expect(:subject, 'Some Subject')
      @message.expect(:body, 'Some Subject')
      @message.expect(:recipient, user)
      @message.expect(:recipient, user)
      @message.expect(:recipient, user)
      @message.expect(:recipient, user)
      @message.expect(:sender, sender)
      @mail = UserMailer.flirt_received_email(@message).deliver
    end
    it "should send a correct email" do
      ActionMailer::Base.deliveries.last.must_equal(@mail)
    end
    it "should assign a correct email" do
      @mail[:to].to_s.must_equal("user@example.com")
    end
    it "should have a subject" do
      @mail[:subject].to_s.must_equal 'You have a flirt at HyeDating.com'
    end
    it "should have an unsubscribe token in the body" do
      @mail.to_s.must_match /users\/unsubscribe_token\/unsubscribe/
    end
  end
  describe "#profile_like_email" do
    before do
      setting = MiniTest::Mock.new
      setting.expect(:likes_email, true)
      recipient = MiniTest::Mock.new
      recipient.expect(:unsubscribe_token, 'unsubscribe_token')
      recipient.expect(:setting, setting)
      recipient.expect(:username, 'uhlala')
      recipient.expect(:email, 'user@example.com')
      sender = MiniTest::Mock.new
      sender.expect(:username, 'uhlala')
      sender.expect(:username, 'uhlala')
      sender.expect(:username, 'uhlala')
      @mail = UserMailer.profile_like_email(sender, recipient).deliver
    end
    it "should send a correct email" do
      ActionMailer::Base.deliveries.last.must_equal(@mail)
    end
    it "should assign a correct email" do
      @mail[:to].to_s.must_equal("user@example.com")
    end
    it "should have a subject" do
      @mail[:subject].to_s.must_equal 'Someone likes your Profile on HyeDating.com'
    end
    it "should have an unsubscribe token in the body" do
      @mail.to_s.must_match /users\/unsubscribe_token\/unsubscribe/
    end
  end
end
