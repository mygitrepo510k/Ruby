class InvitationMailer < ActionMailer::Base
  default from: "enfinitypro@gmail.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.invitation_mailer.invite.subject
  #
  def invite(invitation)
    @message = invitation.invitation_message
    @link = root_url + "/administrator/add_user/#{invitation.id}"

    mail to: invitation.email
  end
end
