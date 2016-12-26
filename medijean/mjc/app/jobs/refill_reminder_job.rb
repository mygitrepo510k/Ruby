class RefillReminderJob
  @queue = :refill_reminder

  def self.perform(id)
    user = User.find_by_id id
    UserMailer.refill_reminder_email(user).deliver
    user.refill_reminder = Time.now().utc
    user.save
    puts "letter refill reminder has been sent to #{user.email}"
  end

  def self.send_refill_reminder(users)
    users.each do |user|
      user.orders.each do |order|
        refill_date = Time.parse(order.placed_at.to_s).to_i+1.month.to_i
        if order.placed_at && refill_date < (Time.now().to_i - 2.weeks.to_i) && refill_date < Time.parse(order.prescription.expiration.to_s).to_i
          if !user.refill_reminder || Time.parse(user.refill_reminder.to_s).to_i < (Time.now()-1.weeks).to_i
            Resque.enqueue(RefillReminderJob, user.id)
          end
        end
      end
    end
  end
end


