require 'netbilling/payment'
class UpgradeController < ApplicationController
  force_ssl if: :production?
  before_action :check_logged_user, :check_logged_non_premium_user
  layout false

  def index
    @payment = Payment.new(current_user)
  end

  def payment
    @payment = Payment.new(current_user, payment_params)
    if @payment.valid?
      processor = Netbilling::Payment.new(@payment, current_user.id.to_s)
      processor.process!
      resp = processor.response
      args = {member_id: resp['member_id'],
          trans_id: resp['trans_id'],
          auth_code: resp['auth_code'],
          auth_date: (Time.parse(resp['auth_date']) rescue nil),
          auth_msg: resp['auth_msg'],
          recurring_id: resp['recurring_id'],
          avs_code: resp['avs_code'],
          cvv2_code: resp['cvv2_code'],
          settle_amount: resp['settle_amount'],
          settle_currency: resp['settle_currency'],
          processor: resp['processor'],
          upgrade_ip_address: request.remote_ip}

      if current_user.subscription.nil?
        current_user.create_subscription(args)
      else
        current_user.subscription.update_attributes(args)
      end

      if resp["status_code"] == "1"
        current_user.subscription.update_attribute(:active, true)
        current_user.update_attribute(:firstname, @payment.first_name)
        current_user.update_attribute(:lastname, @payment.last_name)
        current_user.update_attribute(:zip_code, @payment.zip_code)
        current_user.update_attribute(:country_code, @payment.country_code)
        @rating = RatingCalculator.new(current_user).recalculate_rating
        logger.info("subscription, username: #{current_user.username}, successful")
        return redirect_to users_url(rating: @rating), notice: 'You now enjoy the benefits of a premium account'
      else
        logger.error("subscription, username: #{current_user.username}, error: #{resp.inspect}")
        flash.now[:error] = NetbillingCodes.human_code(resp['auth_msg'])
        return render('index')
      end
    else
      debugger
      flash.now[:error] = "There are some issues with the data you have entered, please fix it to proceed"
    end
    render :index
  end

  private
  def payment_params
    params.require(:payment).permit(:first_name, :last_name, :address, :zip_code,
                                    :country_code, :credit_card_type, :credit_card_number,
                                    :expiry_month, :expiry_year, :security_code, :email)
  end

  def check_logged_non_premium_user
    if user_present? && current_user.premium
      flash[:error] = 'You already are a premium user, you can\'t upgrade twice.'
      redirect_to user_profile_path
    end
  end
end
