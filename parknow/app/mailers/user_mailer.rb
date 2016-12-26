class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers
  default from: "parknow@admin.com"

  def welcome(user)
    @user = user
    #template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[0]).first
    mail(to: @user.email, subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
    UserMailer.send_to_admin(@user).deliver
  end
  
  def send_to_admin(user)
    @user = user
    #template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[6]).first
    mail(to: 'admin@datezr.com', subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
  end

  def reset_password(user)
    @user = user
    raw, enc = Devise.token_generator.generate(user.class, :reset_password_token)
    user.reset_password_token   = enc
    user.reset_password_sent_at = Time.now.utc
    user.save(:validate => false)
    @token = raw    
    #template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[1]).first
    mail(to: @user.email, subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
  end


  def reset_password_instructions(record, set, opts={})
    @user = record
    raw, enc = Devise.token_generator.generate(@user.class, :reset_password_token)
    @user.reset_password_token   = enc
    @user.reset_password_sent_at = Time.now.utc
    @user.save(:validate => false)
    @token = raw    
    #template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[2]).first
    mail(to: @user.email, subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
  end

  def forgot_password(user)
    @user = user
    raw, enc = Devise.token_generator.generate(user.class, :reset_password_token)
    user.reset_password_token   = enc
    user.reset_password_sent_at = Time.now.utc
    user.save(:validate => false)
    @token = raw    
    mail(to: @user.email, subject: 'Forgotten password')
  end
  
  def confirmation_email(name, email, message)
    @name = name
    @email = email
    @message = message
    
    #template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[3]).first
    mail(to: @email, subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
  end

  def contact_us_email(name, email, message)
    @name = name
    @email = email
    @message = message

    #template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[4]).first
    mail(to: @email, subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end

    UserMailer.send_to_admin_contact_us(@name,@email,@message).deliver
  end
  def send_to_admin_contact_us(name, email, message)
    @name = name
    @email = email
    @message = message    
    
    #template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[7]).first
    mail(to: 'admin@datezr.com', subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
  end

  def invitation(invitation)
    if Rails.env=='production'
      host = 'http://parknow.herokuapp.com'
    else
      host = 'http://localhost:3000'
    end
    @invitation = invitation
    @signup_url = host+"/users/sign_up?invite_token=#{invitation.token}"
    @invitation.update_attributes(sent_at:Time.now, state:'pending')
    mail(to: invitation.recipient_email, subject: 'Invitation')
  end


end
