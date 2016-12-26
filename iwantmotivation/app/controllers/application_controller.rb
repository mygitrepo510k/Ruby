class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :get_option, :get_mail_count
  before_filter :online
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end
  
  def paypal_client
    Paypal::Express::Request.new PAYPAL_CONFIG
  end
  DESCRIPTION = {
    item: 'PayPal Express Sample Item',
    instant: 'PayPal Express Sample Instant Payment',
    recurring: 'PayPal Express Sample Recurring Payment'
  }

  def payment_request (amount, recurring)
    request_attributes = if recurring
      {
        billing_type: :RecurringPayments,
        billing_agreement_description: DESCRIPTION[:recurring]
      }
    else
      item = {
        name: DESCRIPTION[:item],
        description: DESCRIPTION[:item],
        amount: amount
      }
      item[:category] = :Digital if self.digital?
      {
        amount: amount,
        description: DESCRIPTION[:instant],
        items: [item]
      }
    end
    Paypal::Payment::Request.new request_attributes
  end
  
  def recurring_request(amount)
    Paypal::Payment::Recurring.new(
      start_date: Time.now,
      description: DESCRIPTION[:recurring],
      billing: {
        period: :Month,
        frequency: 1,
        amount: amount
      }
    )
  end

  def after_sign_in_path_for(resource)    
    if !resource.transaction_cleared
      return admin_home_path if resource.has_role :admin
      sign_out(resource)
      resource.destroy
      flash[:notice] = 'Please register again'
      signup_path
      return
    elsif resource.created_at > 1.minutes.ago
      home_welcome_path
    else
      case resource.roles.last.name
        when 'admin'
          render :text => "ERRORS" and return
          admin_home_path          
        when 'free'
          root_path
        when 'limited'
          content_limited_path
        when 'full'
          content_full_path
        when 'coach'
          content_coach_path
        when 'counselor'
          content_counselor_path
        else
          root_path
      end
    end
  end

  def get_option(opt_name)
    option = Option.find_by_option_name(opt_name)
    return option.option_value if option.present?
  end
  
  def online
    if current_user
      current_user.touch
    end  
  end
  
  def get_mail_count
    current_user.mailbox.receipts.where(:is_read=>false).count if current_user.present?
  end

end