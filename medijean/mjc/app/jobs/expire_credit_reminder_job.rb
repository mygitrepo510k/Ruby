class ExpireCreditReminderJob
  @queue = :expire_credit_reminder

  def self.perform(id, n_days)
      user = User.find_by_id id
      UserMailer.credit_expire_reminder_email(@user,n_days).deliver
      user.expire_reminder = Time.now().utc
      user.save
      puts "letter credit expire reminder has been sent to #{user.email}"
  end

  def self.send_expire_credit_reminder(users)
    users.each do |user|
      if user.payment_profile
        customer = Stripe::Customer.retrieve(user.payment_profile.customer_id)
        card = customer.cards.first
        expire_date =  Date.new(card.exp_year, card.exp_month)
        if expire_date && Time.now().to_i+1.month.to_i < Time.parse(expire_date.to_s).to_i
          Resque.enqueue_at(Time.parse(expire_date.to_s).to_i-1.month.to_i, ExpireCreditReminderJob, user.id, '1 month')
        elsif expire_date && Time.now().to_i+2.weeks.to_i < Time.parse(expire_date.to_s).to_i
          Resque.enqueue_at(Time.parse(expire_date.to_s).to_i-2.weeks.to_i, ExpireCreditReminderJob, user.id, '2 weeks')
        end
      end
    end
  end
end


