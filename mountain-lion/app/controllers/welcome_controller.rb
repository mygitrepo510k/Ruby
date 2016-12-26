class WelcomeController < ApplicationController
  layout 'frontpage'
  def home
    @user = RegistrationOne.new
    if current_user
      if current_user.is_a?(User)
        redirect_to users_url
      else
        redirect_to admin_root_path
      end
    end
  end

  def static_page
    @no_bootstrap = true
    begin
      render params[:page]
    rescue
      redirect_to '/404'
    end
  end

  def confirmation
    render layout: false
  end

  def contact
    unless params[:body].length > 0
      data = params.permit(:full_name, :email, :subject, :message)
      UserMailer.raw_email(contact_email(data), data[:subject], data[:message], data[:email]).deliver
    end
    redirect_to root_url, notice: 'Message sent'
  end

  private
  def contact_email(data)
    data[:subject] =~ /billing/i ? 'billing@hyedating.com' : 'support@hyedating.com'
  end
end
