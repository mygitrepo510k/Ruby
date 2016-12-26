class ProfilesController < ApplicationController

  before_filter :authenticate_user!

  # Update Profiles of Settings
  #
  # @route              PUT /profiles/update
  # @renders            GET /settings/profile
  def update
    @profile = current_user.profile.nil? ? current_user.build_profile : current_user.profile
    phone = params[:profile][:phone].join("-")
    params[:profile][:phone]= phone
    params[:profile][:health_card_number]= current_user.profile.health_card_number.nil? ? 'xxxxxx' : current_user.profile.health_card_number

    @profile.update_attributes params[:profile]

    if @profile.save
      flash[:notice] = t("settings.profile.successfully_updated")
      redirect_to settings_profile_path
    else
      render "profiles/edit"
    end
  end

  # Update Profiles of Settings
  #
  # @route              PUT /profiles/account
  # @renders            GET /settings/account
  def account
    @user = User.find(params[:user][:id])       
    email_changed = @user.email != params[:user][:email]
    
    successfully_updated = if email_changed    
      @user.update_without_password(:email=>params[:user][:email] ) if User.find_by_email(params[:user][:email]).nil?
    end
    
    if @user.role? :patient
      profile = @user.profile
      profile.health_card_number = params[:user][:profile_attributes][:health_card_number]
      successfully_updated = profile.save
    end
    
    if successfully_updated
      flash[:notice] = t("settings.account.successfully_updated")
      redirect_to settings_account_path
    else
      flash[:notice] = t("settings.account.check_again")
      redirect_to settings_account_path
    end
  end

  # Change Password of Settings
  # 
  # @route              PUT /profiles/change_password
  # @renders            GET /settings/account  
  def change_password    
    @user = User.find(params[:user][:id])
    if @user.valid_password?(params[:user][:old_password])
      @user.password = params[:user][:new_password]
      @user.password_confirmation = params[:user][:confirm_new_password]
      @user.skip_confirmation!
    else
      flash[:error] = t("settings.account.check_again_old_paswd")      
      redirect_to settings_account_path and return
    end

    if @user.save
      sign_in(@user, :bypass => true)
      flash[:notice] = t("settings.account.successfully_changed")
      redirect_to settings_account_path
    else
      flash[:error] = @user.errors.messages[:password].first.capitalize
      redirect_to settings_account_path
    end
  end

  # Update Profiles of Settings
  #
  # @route              POST, PUT /profiles/notification
  # @renders            GET /settings/notification
  def notification
    @notification = current_user.notification_settings.nil? ? current_user.build_notification_settings : current_user.notification_settings
    @notification.update_attributes(params[:notification_settings])
    if @notification.save
      flash[:notice] = t("settings.notifications.succesfully_updated")      
      redirect_to settings_notification_path
    else
      redirect_to settings_notification_path
    end
  end
end
