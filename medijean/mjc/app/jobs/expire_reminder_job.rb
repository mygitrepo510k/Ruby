class ExpireReminderJob
  @queue = :expire_reminder

  def self.perform(id)
    user = User.find_by_id id
    UserMailer.expire_reminder_email(user).deliver
    user.expire_reminder = Time.now().utc
    user.save
    puts "letter expire reminder has been sent to #{user.email}"
  end

  def self.send_expire_reminder(users)
    users.each do |user|
      user.prescriptions.each do |prescription|
        if Time.now().to_i+1.month.to_i > Time.parse(prescription.expiration.to_s).to_i
          if !user.expire_reminder || Time.parse(user.expire_reminder.to_s).to_i < Time.now().to_i-1.weeks.to_i
            Resque.enqueue(ExpireReminderJob,user.id)
          end
        end
      end
    end
  end
end

