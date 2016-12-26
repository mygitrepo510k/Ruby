class UserMailer < ActionMailer::Base
  default from: "no-reply@medijean.com"
  layout "mailer"

  def refill_reminder_email(user)
    @user = user
    mail(to: user.email,
         subject: 'MediJean',
         template_path: 'user_mailer',
         template_name: 'refill_reminder_email'
    )
  end

  def expire_reminder_email(user)
    @user = user
    mail(to: user.email,
        subject: 'MediJean',
        template_path: 'user_mailer',
        template_name: 'expire_reminder_email'
    )
  end

  def credit_expire_reminder_email(user, n_days)
    @user = user
    @n_days = n_days
    mail(to: user.email,
        subject: 'MediJean',
        template_path: 'user_mailer',
        template_name: 'credit_expire_reminder_email'
    )
  end

  def complete_order_email(user)
    @user = user
    mail(to: user.email,
         subject: 'MediJean',
         template_path: 'user_mailer',
         template_name: 'complete_order_email'
    )
  end

  def update_order_email(user)
    @user = user
    mail(to: user.email,
         subject: 'MediJean',
         template_path: 'user_mailer',
         template_name: 'update_order_email'
    )
  end

  def prescription_waiting_reminder_email(user)
    @user = user
    mail(to: user.email,
         subject: 'MediJean',
         template_path: 'user_mailer',
         template_name: 'prescription_waiting_reminder_email'
    )
  end

end
