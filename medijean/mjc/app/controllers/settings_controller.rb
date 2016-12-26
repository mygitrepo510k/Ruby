class SettingsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :doctor_profile_update_required, only: [:profile]
  before_filter :user_profile_update_required, only: [:profile]

  # The Settings/Profile Page
  #
  # @route             GET /settings/profile
  # @patient_wireframe https://projects.invisionapp.com/d/main#/console/381469/8780559/preview
  # @doctor_wireframe  https://projects.invisionapp.com/d/main#/console/381469/8769348/preview
  # @patient_renders   profiles/edit.html.haml
  # @doctor_renders    doctors/edit.html.haml
  def profile
    if current_user.role? :patient
    	@profile = current_user.profile || current_user.build_profile
    	@phone = @profile.phone.nil? ? Array.new(3)  :   @profile.phone.split('-')
    	
      render "profiles/edit"
    elsif current_user.role? :doctor
    	@doctor = current_user.linked_doctor || current_user.build_linked_doctor
    	@phone1 = @doctor.phone.nil? ? Array.new(3)  :   @doctor.phone.split('-')
      @phone2 = @doctor.phone.nil? ? Array.new(3)  :   @doctor.clinic.phone.split('-')
      render "doctors/edit"
    end
  end

  # The Settings/Account Page
  #
  # @route             GET /settings/account
  # @patient_wireframe https://projects.invisionapp.com/d/main#/console/381469/8780557/preview
  # @doctor_wireframe  https://projects.invisionapp.com/d/main#/console/381469/8769346/preview
  # @renders           profiles/account.html.haml
  def account
    @user = current_user
    if @user.role? :patient and @user.profile.nil?
      redirect_to settings_profile_path
    end
    render "profiles/account"
  end

  # The Settings/Payment Page
  #
  # @route             GET /settings/payment
  # @wireframe         https://projects.invisionapp.com/d/main#/console/381469/8768537/preview
  # @renders           payment_profiles/show.html.haml
  def payment
    @payment_profile = current_user.payment_profile
    if @payment_profile.present?
      payment = PaymentProvider.new
      customer = payment.get_profile(@payment_profile.customer_id)

      @card_data = customer.card.data[0] if customer.card && customer.card.data.length>0

    end
    render "payment_profiles/show"
  end

  # The Settings/Notifications Page
  #
  # @route             GET /settings/notification
  # @wireframe         https://projects.invisionapp.com/d/main#/console/381469/8780558/preview
  # @renders           profiles/notification.html.haml
  def notification
    @notification = current_user.notification_settings.nil? ? current_user.build_notification_settings : current_user.notification_settings
    render "profiles/notification"
  end
end
