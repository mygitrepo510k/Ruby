class UserMailer < ActionMailer::Base
  default :from => "notifications@example.com"
  
  def expire_email(user)
    mail(:to => user.email, :subject => "Subscription Cancelled")
  end

  def signed_success(recipient, subject, message, sent_at=Time.now)
    @body = {}
  	@subject=subject
  	@recipient = recipient
  	@from = 'lee@iwantmotivation.com'
  	@sent_on=sent_at
  	@body["title"]="Welcome"
  	@body["email"]="lee@iwantmotivation.herokuapp.com"
  	@body["message"]=message
  end

  def updated_user(user)
    mail(:to => user.email, :subject => "Updated user")
  end

  def updated_plan(user)
    mail(:to => user.email, :subject => "Updated plan")
  end
end