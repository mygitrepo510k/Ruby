require 'spec_helper'
require 'resque_spec/scheduler'

describe PrescriptionWaitingReminderJob do

  describe "#prescription_waiting_reminder" do
    let(:user) {FactoryGirl.create(:user)}
    before do
      ResqueSpec.reset!
    end

    it "enqueue the job for sending prescription waiting reminder letter" do
      Resque.enqueue(PrescriptionWaitingReminderJob)
      PrescriptionWaitingReminderJob.should have_queue_size_of(1)
    end

    it "test set schedule" do
      Resque.set_schedule("prescription_waiting_reminder_job", {
          'cron' => "0 15 * * *", 'class' => 'PrescriptionWaitingReminderJob', 'args' => "args"
      })
      assert_equal({'cron' => "0 15 * * *", 'class' => 'PrescriptionWaitingReminderJob', 'args' => "args"},
                   Resque.decode(Resque.redis.hget(:schedules, "prescription_waiting_reminder_job")))
    end

    it "test load schedule" do
      Resque.redis.hset(:schedules, "prescription_waiting_reminder_job", Resque.encode(
          {'cron' => "0 15 * * *", 'class' => 'PrescriptionWaitingReminderJob', 'args' => "args"}
      ))
      assert_equal({'cron' => "0 15 * * *", 'class' => 'PrescriptionWaitingReminderJob', 'args' => "args"},
                   Resque.get_schedule("prescription_waiting_reminder_job"))
    end

  end

end