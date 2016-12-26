class PrescriptionWaitingReminderJob
  @queue = :prescription_waiting_reminder

  def self.perform(*args)
    users = User.all
    users.each do |user|
      user.prescriptions.each do |prescription|
        if prescription.status == :uploaded
          UserMailer.prescription_waiting_reminder_email(user).deliver
        end
      end
    end
  end
end
