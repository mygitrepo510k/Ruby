class UserMailer < ActionMailer::Base
  include Devise::Mailers::Helpers
  default from: "admin@headcount.com"

  def welcome(user)
    @user = user
    template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[0]).first
    mail(to: @user.email, subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
    UserMailer.send_to_admin(@user).deliver
  end
  
  def send_to_admin(user)
    @user = user
    template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[6]).first
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
    template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[1]).first
    mail(to: @user.email, subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
  end

  def created_contact(contact)
  	@contact = contact    
    template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[5]).first
    mail(to: @contact.email, subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
  end
  
  def confirmation_instructions(record, set, opts={})
  end

  def reset_password_instructions(record, set, opts={})
    @user = record
    raw, enc = Devise.token_generator.generate(@user.class, :reset_password_token)
    @user.reset_password_token   = enc
    @user.reset_password_sent_at = Time.now.utc
    @user.save(:validate => false)
    @token = raw    
    template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[2]).first
    mail(to: @user.email, subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
  end

  def unlock_instructions(record, set, opts={})
  end

  def forgotten_password(user)
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
    
    template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[3]).first
    mail(to: @email, subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
  end

  def contact_us_email(name, email, message)
    @name = name
    @email = email
    @message = message

    template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[4]).first
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
    
    template = MailTemplate.where(name:MailTemplate::MAIL_TEMPLATES[7]).first
    mail(to: 'admin@datezr.com', subject: template.subject) do |format|
      format.html{render :inline => template.content_html}
      format.text{render :inline => template.content_html}
    end
  end
end
