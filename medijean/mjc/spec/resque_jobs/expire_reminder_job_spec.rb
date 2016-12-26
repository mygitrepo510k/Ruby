require 'spec_helper'

  describe "#refill_reminder" do
    let(:user) {FactoryGirl.create(:user, expire_reminder: Time.at(Time.now().to_i-1.month.to_i).utc)}
    let(:order) {FactoryGirl.create(:order, user: user)}
    let (:prescription)  {FactoryGirl.create(:prescription, user: order.user, expiration: Time.at(Time.now().to_i+2.week.to_i).utc)}
    before do
      ResqueSpec.reset!
    end

    it "enqueue the job for sending expire reminder letter" do
      Resque.enqueue(ExpireReminderJob, user.id)
      ExpireReminderJob.should have_queue_size_of(1)
    end

    it "Find users whose prescription is less than a month from expiration" do
      order.prescription = prescription
      ExpireReminderJob.send_expire_reminder([user])
      ExpireReminderJob.should have_queue_size_of(1)
    end

    it "Find users whose not need sending refill reminder" do
      ExpireReminderJob.send_expire_reminder([user])
      ExpireReminderJob.should have_queue_size_of(0)
    end
  end

