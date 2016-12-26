class VoiceMailer < ActionMailer::Base
  default from: "voices@paradigmagency.com"

	def send_voice_list(admin, list)
		@admin = admin
		@list = list
    @subject = "#{list.recipient_name}, here is your Paradigm Agency voiceovers list"
    @subject = "Paradigm Agency Voiceovers"
    @subject = list.subject if list.subject.present?
    @recipients = "#{list.recipient}"
    setup_email(admin) do |format|
      format.html { render :layout => 'application' }
      format.text
    end
    mail(to: "#{list.recipient}", subject: @subject)
	end


protected

  def setup_email(admin)
    @from = "<voices@paradigmagency.com>"
    @sent_on = Time.now
    @admin = admin
  end
	
end
