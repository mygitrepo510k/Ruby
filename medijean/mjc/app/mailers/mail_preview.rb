class MailPreview < MailView

  def refill_reminder
    UserMailer.refill_reminder_email(get_user)
  end

  def expire_reminder
    UserMailer.refill_reminder_email(get_user)
  end

  def credit_expire_reminder
    UserMailer.credit_expire_reminder_email(get_user, 3)
  end

  def complete_order
    UserMailer.complete_order_email(get_user)
  end

  def update_order
    UserMailer.update_order_email(get_user)
  end

  def prescription_waiting_reminder
    UserMailer.prescription_waiting_reminder_email(get_user)
  end

  def devise_confirmation_instructions
    Devise::Mailer.confirmation_instructions(get_user)
  end

  def devise_reset_password_instructions
    Devise::Mailer.reset_password_instructions(get_user)
  end

  protected

  def get_user
    User.new(email: Faker::Internet.email,invitation_token: 'invitation-token')
  end

end