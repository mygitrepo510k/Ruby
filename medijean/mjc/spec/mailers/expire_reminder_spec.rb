require 'spec_helper'

describe UserMailer do
  before { ActionMailer::Base.deliveries.clear }
  describe 'refill reminder email' do
    let(:user) { mock_model(User, :name => 'Kirill', :email => 'hmelev.kirill.dunice@gmail.com') }
    let(:mail) { UserMailer.expire_reminder_email(user) }
    it 'renders the subject' do
      mail.subject.should == 'MediJean'
    end

    it 'renders the receiver email' do
      mail.to.should == [user.email]
    end

    it 'renders the sender email' do
      mail.from.should == ["no-reply@medijean.com"]
    end

    it 'assigns @name' do
      mail.body.encoded.should match(user.name)
    end

    it "sending refill reminder email" do
      mail.deliver
      ActionMailer::Base.deliveries.should_not be_empty
    end
  end
end