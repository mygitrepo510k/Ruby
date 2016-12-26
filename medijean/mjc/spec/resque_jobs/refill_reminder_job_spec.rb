require 'spec_helper'

describe RefillReminderJob do

  describe "#refill_reminder" do
    let(:user) {FactoryGirl.create(:user, refill_reminder: Time.at(Time.now().to_i-1.month.to_i).utc)}
    let(:order) {FactoryGirl.create(:order, user: user, placed_at: Time.at(Time.now().to_i - 1.month.to_i - 2.week.to_i - 2.day.to_i).utc)}
    let (:prescription)  {FactoryGirl.create(:prescription, user: order.user, expiration: Time.at(Time.parse(order.placed_at.to_s).to_i + 1.month.to_i + 2.day.to_i).utc)}

    before do
      ResqueSpec.reset!
    end

    it "enqueue the job for sending refill reminder letter" do
      Resque.enqueue(RefillReminderJob, user.id)
      RefillReminderJob.should have_queue_size_of(1)
    end

    it "Find users whose need sending refill reminder" do
      order.prescription = prescription
      RefillReminderJob.send_refill_reminder([user])
      RefillReminderJob.should have_queue_size_of(1)
    end

    it "Find users whose not need sending refill reminder" do
      RefillReminderJob.send_refill_reminder([user])
      RefillReminderJob.should have_queue_size_of(0)
    end
  end

end