class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url  = "http://ec2-54-244-185-69.us-west-2.compute.amazonaws.com/verify_account?id=" + @user.email_verification_hash
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end

  def welcome_email_pre_member(user)
    @user = user
    @url  = "http://ec2-54-244-185-69.us-west-2.compute.amazonaws.com"
    mail(:to => user.email, :subject => "Welcome to My Awesome Site")
  end
  
  def family_member_welcome_email(family_member)
    @family_member = family_member
    @url  = "http://ec2-54-244-185-69.us-west-2.compute.amazonaws.com/verify_family_member?id=" + @family_member.email_verification_hash
    mail(:to => family_member.email, :subject => "Welcome to My Awesome Site And Verify Family")
  end
  
  def family_assosiate_request_email(family_member)
    @family_member = family_member
    @url  = "http://ec2-54-244-185-69.us-west-2.compute.amazonaws.com/verify_family_member?id=" + @family_member.email_verification_hash + "&verify_request=true"
    mail(:to => @family_member.family.user.email, :subject => "Request To Verify Family Member")
  end
  
  def family_assosiate_request_status_email(family_member)
    @family_member = family_member
    mail(:to => @family_member.email, :subject => "Request To Verify Family Member")
  end

  def family_assosiate_request_status_email_by_user(family_member)
    @user = family_member.family.user
    @family_member = family_member
    mail(:to => @user.email, :subject => "Request To Join Family As Member")
  end

  def forgot_password_email(user,password)
  	@user = user
  	@password = password
    @url  = "http://ec2-54-244-185-69.us-west-2.compute.amazonaws.com"
    mail(:to => user.email, :subject => "Forgot Password.")
  end
  
end
