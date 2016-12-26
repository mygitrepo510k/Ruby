require 'spec_helper'
require 'resque_spec/scheduler'

describe ExpireCreditReminderJob do
  let(:card_token) {Stripe::Token.create(card: {number: '4242424242424242', exp_month: Time.now().month+2, exp_year: Time.now().year})}
  let(:customer) {Stripe::Customer.create(card: card_token.id, description: "A Customer")}
  let(:payment_profile) {FactoryGirl.create(:payment_profile)}
  let(:user) {FactoryGirl.create(:user)}

  describe "#refill_reminder" do
    before do
      ResqueSpec.reset!
    end

    it "enqueue the job for sending expire credit reminder letter" do
      Resque.enqueue(ExpireCreditReminderJob, user.id, '1 month')
      ExpireCreditReminderJob.should have_queue_size_of(1)
    end

    it "Find users whose credit card on file is expiring" do
      user.payment_profile = payment_profile
      user.payment_profile.customer_id = customer.id

      ExpireCreditReminderJob.send_expire_credit_reminder([user])

      ExpireCreditReminderJob.should have_schedule_size_of(1)

    end

  end

end