class UserMailer < ActionMailer::Base
  add_template_helper(UsersHelper)
  default from: "HyeDating <support@hyedating.com>"
  def activation_needed_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('emails.activation.subject'))
  end

  def activation_success_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('emails.activation_success.subject'))
  end

  def reset_password_email(user)
    @user = user
    mail(to: @user.email, subject: I18n.t('emails.password_reset.subject'))
  end

  def raw_email(email, subject, body, from = 'donotreply@hyedating.com')
    mail(
      to: email,
      subject: subject,
      from: from
    ) do |format|
      format.text { render :text => body }
    end
  end

  def message_received_email(message)
    @message = message
    if @message.recipient.setting.messages_email
      mail(
        to: @message.recipient.email,
        subject: 'You have a new message at HyeDating.com')
    end
  end

  def flirt_received_email(flirt)
    @flirt = flirt
    if @flirt.recipient.setting.flirts_email
      mail(
        to: @flirt.recipient.email,
        subject: 'You have a flirt at HyeDating.com')
    end
  end

  def profile_like_email(sender, recipient)
    @sender = sender
    @recipient = recipient
    if @recipient.setting.likes_email
      mail(to: recipient.email, subject: 'Someone likes your Profile on HyeDating.com')
    end
  end

  def profile_views_email(user, users)
    @user = user
    @users = users
    mail(to: @user.email, subject: "Members who looked at your profile on HyeDating.com")
  end

  def new_users_email(user, new_users)
    @user = user
    @new_users = new_users
    mail(to: @user.email, subject: "New Members this Week on HyeDating.com")
  end
end
